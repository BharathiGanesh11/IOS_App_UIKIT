//
//  GFInfoItemView.swift
//  GitHub Followers
//
//  Created by Kumar on 26/08/24.
//

import UIKit

enum InfoItemType
{
    case repos
    case gists
    case followers
    case following
    
    var title : String
    {
        switch self {
        case .repos:
            return "Public Repos"
        case .gists:
            return "Public Gists"
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        }
    }
    
    var icon : UIImage
    {
        switch self {
        case .repos:
            return UIImage(systemName: SFSymbols.repos)!
        case .gists:
            return UIImage(systemName: SFSymbols.gists)!
        case .followers:
            return UIImage(systemName: SFSymbols.followers)!
        case .following:
            return UIImage(systemName: SFSymbols.following)!
        }
    }
}

class GFInfoItemView: UIView {
    
    let iconImageView = UIImageView()
    let titleLabel = GFtitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFtitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI()
    {
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(withType infoItemType : InfoItemType , withCount count : Int)
    {
        iconImageView.image = infoItemType.icon
        titleLabel.text = infoItemType.title
        countLabel.text = "\(count)"
    }
}
