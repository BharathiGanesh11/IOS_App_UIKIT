//
//  FavoritesCellTableViewCell.swift
//  GitHub Followers
//
//  Created by Kumar on 29/08/24.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFtitleLabel(textAlignment: .left, fontSize: 26)
    
    static let reuseID = "FavoritesCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config()
    {
        accessoryType = .disclosureIndicator
        
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func set(favorites : Follower)
    {
        print("in set func \(favorites)")
        avatarImageView.downloadAvatar(urlString: favorites.avatarUrl)
        userNameLabel.text = favorites.login
    }
    
}
