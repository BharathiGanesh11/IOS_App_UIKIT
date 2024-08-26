//
//  RepoAndGistInfoVC.swift
//  GitHub Followers
//
//  Created by Kumar on 26/08/24.
//

import UIKit

class RepoAndGistInfoVC : GFInfoItemVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI()
    {
        InfoViewOne.set(withType: .repos, withCount: user.publicRepos)
        InfoViewTwo.set(withType: .gists, withCount: user.publicGists)
        
        button.set(background: .systemPurple, title: "Get Profile")
    }
}
