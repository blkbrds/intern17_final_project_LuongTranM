//
//  HomeViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class HomeViewController: UIViewController {

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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

}

extension HomeViewController {
    private struct Define {
        static var title: String = "Discover"
    }
}
