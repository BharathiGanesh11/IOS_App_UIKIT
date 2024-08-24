//
//  UserInfoVCViewController.swift
//  GitHub Followers
//
//  Created by Kumar on 24/08/24.
//

import UIKit

class UserInfoVCViewController: UIViewController {
    
    var userName : String!
    
    let headerContainerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        
        GFNetworkManager.shared.getUserInfo(userName: userName) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                print(userInfo)
                DispatchQueue.main.async {
                    self.addChildVC(vc: UserInfoHeaderVC(userInfo: userInfo), view: self.headerContainerView)
                }
            case .failure(let error):
                presentCustomAlert(alertTitle: "Something Went Wrong", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }

    }
    
    func layoutUI()
    {
        view.addSubview(headerContainerView)
        
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: 180),
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
