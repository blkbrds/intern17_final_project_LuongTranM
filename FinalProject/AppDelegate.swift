//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/25/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum RootType {
        case login
        case home
    }

    var window: UIWindow?
    var rootType: RootType = .login

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        changeRoot(rootType: .home)
        window?.makeKeyAndVisible()
        return true
    }

    func changeRoot(rootType: RootType) {
        switch rootType {
        case .login:
            changeRootToLogin()
        case .home:
            changeRootToHome()
        }
    }

    func changeRootToHome() {
        let tabbarVC = BaseTabbarViewController()
        tabbarVC.configTabbar()
        window?.rootViewController = tabbarVC
    }

    func changeRootToLogin() {
        let loginVC = LoginViewController()
        loginVC.viewModel = LoginViewModel()
        let navigationController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navigationController
    }

}
