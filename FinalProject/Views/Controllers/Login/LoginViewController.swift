//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import UIKit

final class LoginViewController: UIViewController {

    var viewModel: LoginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LOGIN"
    }

    // MARK: - Actions
    @IBAction func againButtonTouchUpInside(_ sender: UIButton) {
        getAPI()
    }
}

// MARK: - APIs
extension LoginViewController {

    private func getAPI() {
        viewModel.requestAPI { result in
            print(result)
        }
    }
}
