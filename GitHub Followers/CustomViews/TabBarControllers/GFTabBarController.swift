//
//  GFTabBarController.swift
//  GitHub Followers
//
//  Created by Kumar on 30/08/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBarVC()
        configNavigatioBar()
    }

    func configTabBarVC()
    {
        //tabVC.tabBar.isTranslucent = false
        //tabVC.tabBar.barTintColor = .systemGray
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchListNC() , createFavoritesListNC()]
    }
    
    func createSearchListNC() -> UINavigationController
    {
        let vc = SearchListVC()
        vc.title = "Search"
        //vc.navigationItem.largeTitleDisplayMode = .inline
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let NC = UINavigationController(rootViewController: vc)
        return NC
    }
    
    func createFavoritesListNC() -> UINavigationController
    {
        let vc = FavoritesListVC()
        vc.title = "Favorites"
        vc.navigationItem.largeTitleDisplayMode = .inline
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let NC = UINavigationController(rootViewController: vc)
        return NC
    }
    
    func configNavigatioBar()
    {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
}
