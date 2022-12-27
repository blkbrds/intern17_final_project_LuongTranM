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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: Private methods
    private func configUI() {
        configTextField()
        configButton()
        addGestureForRegisterLabel()
        configGradient()
    }

    private func addGestureForRegisterLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTapTouchUpInside))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(tapGesture)
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
        usernameTextField.delegate = self
        passwordTextField.setupLeftSideImage(imageViewName: "key.fill")
        passwordTextField.layer.cornerRadius = Define.cornerRadius
        passwordTextField.underlined()
        passwordTextField.delegate = self
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
    @IBAction private func checkValidEmailTextfield(_ sender: UITextField) {
        let isEmail = sender.text.content.checkTypeRegex(typeRegex: .email)
        if isEmail {
            sender.tintColor = .black
            loginButton.isEnabled = true
        } else {
            sender.tintColor = .red
            loginButton.isEnabled = false
        }
    }

    @IBAction private func loginButtonTouchUpInside(_ sender: Any) {
        guard let email = usernameTextField.text,
              let password = passwordTextField.text else { return }
        if email.isEmpty && password.isEmpty {
            alert(msg: "Email and password are empty", completion: nil)
        } else {
            requestLogin(email: email, password: password)
        }
    }

    @IBAction private func loginFacebookButtonTouchUpInside(_ sender: Any) {
        #warning("Login by facebook")
    }

    @IBAction private func loginGmailButtonTouchUpInside(_ sender: Any) {
        #warning("Login by gmail")
    }

    // MARK: Objc methods
    @objc private func registerTapTouchUpInside(sender: UITapGestureRecognizer) {
        #warning("Register account")
    }
}

// MARK: - APIs
extension LoginViewController {

    private func requestLogin(email: String, password: String) {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.requestLoginAPI(email: email, password: password, completion: { [weak self] result in
            self?.dismissHUD()
            guard let this = self else { return }
            switch result {
            case .success:
                AppDelegate.shared.setRoot(rootType: .home)
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        })
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case usernameTextField:
            textField.becomeFirstResponder()
        case passwordTextField:
            textField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
    }
}
