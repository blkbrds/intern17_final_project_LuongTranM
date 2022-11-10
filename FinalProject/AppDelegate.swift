//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/25/22.
//

import UIKit

let ud = UserDefaults.standard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum RootType {
        case login
        case home
    }

    static var shared: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get AppDelegate")
        }
        return delegate
    }()

    var window: UIWindow?
    var rootType: RootType = .login

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        (setRoot(rootType: .home))
        return true
    }

    func setRoot(rootType: RootType) {
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
