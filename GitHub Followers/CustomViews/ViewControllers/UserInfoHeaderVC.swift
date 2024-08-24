//
//  UserInfoHeaderVC.swift
//  GitHub Followers
//
//  Created by Kumar on 24/08/24.
//

import UIKit

class UserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNamelabel = GFtitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryLabel(fontSize: 18)
    let locationLabel = GFSecondaryLabel(fontSize: 18)
    let bioLabel = GFbodyLabel(textAlignment: .left)
    let locationImageView = UIImageView()
    
    var userInfo : User!
    
    init(userInfo: User) {
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        configUIComponents()
    }
    
    func layoutUI()
    {
        view.addSubview(avatarImageView)
        view.addSubview(userNamelabel)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
        view.addSubview(locationImageView)
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.contentMode = .scaleAspectFit
        
        let padding : CGFloat = 20
        let textImagePadding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userNamelabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNamelabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNamelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNamelabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: userNamelabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: userNamelabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configUIComponents()
    {
        avatarImageView.downloadAvatar(urlString: userInfo.avatarUrl)
        userNamelabel.text = userInfo.login
        nameLabel.text = userInfo.name ?? "NA"
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationLabel.text = userInfo.location ?? "NA"
        bioLabel.numberOfLines = 3
        bioLabel.text = userInfo.bio ?? "No bio Available"
    }

}
