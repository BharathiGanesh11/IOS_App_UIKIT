//
//  UserInfoVCViewController.swift
//  GitHub Followers
//
//  Created by Kumar on 24/08/24.
//

import UIKit

class UserInfoVCV: UIViewController {
    
    var userName : String!
    
    let headerContainerView = UIView()
    let infoRepoConainerView = UIView()
    let infoFollowerContainerView = UIView()
    
    var containerViews : [UIView] = []

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
                    self.addChildVC(vc: UserInfoHeaderVC(userInfo: userInfo), view: self.headerContainerView)
                    self.addChildVC(vc: RepoAndGistInfoVC(user: userInfo), view: self.infoRepoConainerView)
                    self.addChildVC(vc: FollowingAndFollowersInfoVC(user: userInfo), view: self.infoFollowerContainerView)
                }
            case .failure(let error):
                presentCustomAlert(alertTitle: "Something Went Wrong", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    func layoutUI()
    {
        let padding : CGFloat = 20
        
        containerViews = [headerContainerView , infoRepoConainerView , infoFollowerContainerView]
        
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
