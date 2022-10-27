//
//  BaseTabbarViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import Foundation
import UIKit

final class BaseTabbarViewController: UITabBarController {

    private static var sharedTabbarManager: BaseTabbarViewController = {
        let tabbarManager = BaseTabbarViewController()
        return tabbarManager
    }()

    class func shared() -> BaseTabbarViewController {
        return sharedTabbarManager
    }

    func configTabbar() {
        let homeVC = HomeViewController()
        if #available(iOS 13.0, *) {
            homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        }
//        homeVC.viewModel = HomeViewModel()
        let homeNavigationController = UINavigationController(rootViewController: homeVC)

        let searchVC = SearchViewController()
        if #available(iOS 13.0, *) {
            searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
            searchVC.tabBarItem.title = "Search"
        }
//        searchVC.viewModel = SearchViewModel()
        let searchNavigationController = UINavigationController(rootViewController: searchVC)

        let favoriteVC = FavoriteViewController()
        if #available(iOS 13.0, *) {
            favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        }
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteVC)

        let profileVC = ProfileViewController()
        if #available(iOS 13.0, *) {
            profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
        }
//        profileVC.viewModel = ProfileViewModel()
        let profileNavigationController = UINavigationController(rootViewController: profileVC)

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white

            tabBar.scrollEdgeAppearance = appearance
            tabBar.standardAppearance = appearance
            tabBar.tintColor = .red
        }

        self.viewControllers = [homeNavigationController, searchNavigationController, favoriteNavigationController, profileNavigationController]
    }

}
