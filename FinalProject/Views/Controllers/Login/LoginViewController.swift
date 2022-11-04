//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var facebookButton: UIButton!
    @IBOutlet private weak var gmailButton: UIButton!
    @IBOutlet private weak var registerLabel: UILabel!

    // MARK: Properties
    var viewModel: LoginViewModel?

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Define.title
        configUI()
    }

    // MARK: Private methods
    private func configUI() {
        configTextField()
        configButton()
        configLabel()
        configGradient()
    }

    private func configLabel() {
        let tapRegisterLabel = UITapGestureRecognizer(target: self, action: #selector(registerTapTouchUpInside))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(tapRegisterLabel)
    }

    private func configGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = Define.gradientColor
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func configTextField() {
        usernameTextField.setupLeftSideImage(imageViewName: "person.fill")
        usernameTextField.layer.cornerRadius = Define.cornerRadius
        usernameTextField.underlined()
        passwordTextField.setupLeftSideImage(imageViewName: "key.fill")
        passwordTextField.layer.cornerRadius = Define.cornerRadius
        passwordTextField.underlined()
    }

    private func configButton() {
        // Login Button
        loginButton.layer.cornerRadius = Define.cornerRadius
        // Facebook Button
        facebookButton.layer.cornerRadius = Define.cornerRadius
        facebookButton.layer.borderWidth = Define.borderWidth
        facebookButton.layer.borderColor = Define.borderColor
        // Gmail Button
        gmailButton.layer.cornerRadius = Define.cornerRadius
        gmailButton.layer.borderWidth = Define.borderWidth
        gmailButton.layer.borderColor = Define.borderColor
    }

    // MARK: Action methods
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        print("login")
    }

    @IBAction func loginFacebookButtonTouchUpInside(_ sender: Any) {
        print("facebook")
    }

    @IBAction func loginGmailButtonTouchUpInside(_ sender: Any) {
        print("gmail")
    }

    // MARK: Objc methods
    @objc private func registerTapTouchUpInside(sender: UITapGestureRecognizer) {
//        let vc = RegisterViewController()
//        vc.viewModel = RegisterViewModel()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Define
extension LoginViewController {
    private struct Define {
        static var title: String = "Login"
        static var cornerRadius: CGFloat = 10.0
        static var borderWidth: CGFloat = 1.0
        static var borderColor: CGColor = UIColor.systemGreen.cgColor
        static var gradientColor: [CGColor] = [
            CGColor(_colorLiteralRed: 0.69, green: 0.95, blue: 0.95, alpha: 1.00),
            CGColor(_colorLiteralRed: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        ]
    }
}
