//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func configNavigation() {
        navigationItem.title = Define.title
    }

}

extension ProfileViewController {
    private struct Define {
        static var title: String = "Profile"
    }
}
