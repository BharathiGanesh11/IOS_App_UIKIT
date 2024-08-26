//
//  FollowingAndFollowersInfoVC.swift
//  GitHub Followers
//
//  Created by Kumar on 26/08/24.
//

import UIKit

class FollowingAndFollowersInfoVC : GFInfoItemVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI()
    {
        InfoViewOne.set(withType: .following, withCount: user.following)
        InfoViewTwo.set(withType: .followers, withCount: user.followers)
        
        button.set(background: .systemGreen, title: "Get Followers")
    }
}
