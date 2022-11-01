//
//  BaseTabbarViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import Foundation
import UIKit

final class BaseTabbarViewController: UITabBarController {

    func configTabbar() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        homeVC.viewModel = HomeViewModel()
        let homeNavigationController = UINavigationController(rootViewController: homeVC)

        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchVC.viewModel = SearchViewModel()
        let searchNavigationController = UINavigationController(rootViewController: searchVC)

        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        favoriteVC.viewModel = FavoriteViewModel()
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteVC)

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
        let profileNavigationController = UINavigationController(rootViewController: profileVC)

        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = .init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        tabBar.tintColor = .red

        self.viewControllers = [homeNavigationController, searchNavigationController, favoriteNavigationController, profileNavigationController]
    }

}
