//
//  FollowersEmptyState.swift
//  GitHub Followers
//
//  Created by Kumar on 20/08/24.
//

import UIKit

class FollowersEmptyState: UIView {
    
    var messageLabel = GFtitleLabel(textAlignment: .center, fontSize: 20)
    var emptyStateImageView = UIImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message : String)
    {
        super.init(frame: .zero)
        messageLabel.text = message
        config()
    }
    
    func config()
    {
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 3
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageLabel)
        
        emptyStateImageView.image = UIImage(named: "EmptyState")
        emptyStateImageView.contentMode = .scaleAspectFit
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(emptyStateImageView)
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            emptyStateImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            emptyStateImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            emptyStateImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 120),
            emptyStateImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 70)
        ])
    }
}
