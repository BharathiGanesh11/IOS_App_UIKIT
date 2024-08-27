//
//  UserInfoVCViewController.swift
//  GitHub Followers
//
//  Created by Kumar on 24/08/24.
//

import UIKit

protocol UserInfoVCVDelegate : AnyObject
{
    func didTapGetProfile(with user : User)
    func didTapGetFollowers(with user : User)
}

class UserInfoVCV: UIViewController {
    
    var userName : String!
    
    let headerContainerView = UIView()
    let infoRepoConainerView = UIView()
    let infoFollowerContainerView = UIView()
    let dateLabel = GFbodyLabel(textAlignment: .center)
    
    var containerViews : [UIView] = []
    
    weak var delegate : FollowersListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        getUserInfo()
    }
    
    func getUserInfo()
    {
        GFNetworkManager.shared.getUserInfo(userName: userName) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                print(userInfo)
                DispatchQueue.main.async {
                    self.configUIComponents(with: userInfo)
                }
            case .failure(let error):
                presentCustomAlert(alertTitle: "Something Went Wrong", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    func configUIComponents(with user : User)
    {
        let repoAndGistVC = RepoAndGistInfoVC(user: user)
        repoAndGistVC.delegate = self
        
        let followingAndFollowersVC = FollowingAndFollowersInfoVC(user: user)
        followingAndFollowersVC.delegate = self
        
        addChildVC(vc: UserInfoHeaderVC(userInfo: user), view: self.headerContainerView)
        addChildVC(vc: repoAndGistVC, view: self.infoRepoConainerView)
        addChildVC(vc: followingAndFollowersVC, view: infoFollowerContainerView)
        dateLabel.text = "Github since \(user.createdAt.convertToGFDateFormat())"
    }
    
    func layoutUI()
    {
        let padding : CGFloat = 20
        
        containerViews = [headerContainerView , infoRepoConainerView , infoFollowerContainerView , dateLabel]
        
        for containerView in containerViews {
            view.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: 180),
            
            infoRepoConainerView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 12),
            infoRepoConainerView.heightAnchor.constraint(equalToConstant: 150),
            
            infoFollowerContainerView.topAnchor.constraint(equalTo: infoRepoConainerView.bottomAnchor, constant: 12),
            infoFollowerContainerView.heightAnchor.constraint(equalToConstant: 150),
            
            dateLabel.topAnchor.constraint(equalTo: infoFollowerContainerView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func addChildVC(vc : UIViewController , view : UIView)
    {
        addChild(vc)
        vc.view.frame = view.bounds
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @objc func dismissVC()
    {
        self.dismiss(animated: true)
    }
}

extension UserInfoVCV : UserInfoVCVDelegate
{
    func didTapGetProfile(with user : User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCustomAlert(alertTitle: "Invalid URL", alertMessage: "The url attached with this profile is Invalid!", btnTitle: "Ok")
            return
        }
        
        presentSafariWebView(url: url)
    }
    
    func didTapGetFollowers(with user : User) {
        guard user.followers != 0 else {
            presentCustomAlert(alertTitle: "GitHub", alertMessage: "This user dosent have followers", btnTitle: "so sad")
            return
        }
        
        dismissVC()
        delegate.reloadWithNewUser(username: user.login)
    }
}
