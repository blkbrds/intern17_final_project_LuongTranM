//
//  PaymentViewController.swift
//  FinalProject
//
//  Created by luong.tran on 21/11/2022.
//

import UIKit

final class PaymentViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var selectedLabel: UILabel!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var paymentButton: UIButton!

    // MARK: Properties
    var viewModel: PaymentViewModel?

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configUI()
        configTableView()
        getApiUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(false)
    }

    // MARK: Private methods
    private func configNavigation() {
        setTitleNavigation(type: .payment)
        setLeftBarButton(imageString: "chevron", tintColor: .black, action: #selector(returnButtonTouchUpInside))
    }

    private func configUI() {
        paymentButton.layer.cornerRadius = Define.cornerRadius
        // Name Textfield
        nameTextField.delegate = self
        nameTextField.layer.cornerRadius = Define.cornerRadius
        nameTextField.layer.borderWidth = Define.borderWidth
        nameTextField.layer.borderColor = Define.borderColor
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        // Phone Textfield
        phoneTextField.delegate = self
        phoneTextField.layer.cornerRadius = Define.cornerRadius
        phoneTextField.layer.borderWidth = Define.borderWidth
        phoneTextField.layer.borderColor = Define.borderColor
        phoneTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: phoneTextField.frame.height))
        phoneTextField.leftViewMode = .always
        // Address Textfield
        addressTextField.delegate = self
        addressTextField.layer.cornerRadius = Define.cornerRadius
        addressTextField.layer.borderWidth = Define.borderWidth
        addressTextField.layer.borderColor = Define.borderColor
        addressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: addressTextField.frame.height))
        addressTextField.leftViewMode = .always
    }

    private func configTableView() {
        let nib = UINib(nibName: Define.cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Define.cellName)
        tableView.estimatedRowHeight = Define.estimatedRowHeight
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        selectedLabel.text = "Total Product (\(viewModel.carts.count))"
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: viewModel.totalMoney as NSNumber) {
            totalPriceLabel.text = "\(formattedTipAmount)"
        }
    }

    private func requestBodyPayment() -> Payment? {
        guard let viewModel = viewModel,
              let userName = nameTextField.text,
              let phoneNumber = phoneTextField.text,
              let address = addressTextField.text else {
            return nil
        }
        var ordersIds: [Int] = []
        for index in viewModel.carts {
            ordersIds.append(index.id)
        }
        guard phoneNumber.isNumeric && phoneNumber.count <= 11 else {
            alert(msg: "Format invalid", completion: nil)
            return nil
        }
        return Payment(orderIds: ordersIds, userName: userName, phoneNumber: phoneNumber, address: address, amount: viewModel.totalMoney)
    }

    // MARK: Action methods
    @IBAction private func checkChangedPhoneTextfield(_ sender: UITextField) {
        let phone = phoneTextField.text.content
        if phone.count <= 11 && phone.isNumeric && !phone.isEmpty {
            sender.layer.borderColor = UIColor.systemGray5.cgColor
            paymentButton.isEnabled = true
        } else {
            sender.layer.borderColor = .init(red: 0.89, green: 0.32, blue: 0.32, alpha: 1.00)
            paymentButton.isEnabled = false
        }
    }

    @IBAction private func checkChangedNameTextfield(_ sender: UITextField) {
        let isContainsNumber = sender.text.content.checkTypeRegex(typeRegex: .number)
        if !isContainsNumber && !sender.text.content.isEmpty {
            sender.layer.borderColor = UIColor.systemGray5.cgColor
            paymentButton.isEnabled = true
        } else {
            sender.layer.borderColor = .init(red: 0.89, green: 0.32, blue: 0.32, alpha: 1.00)
            paymentButton.isEnabled = false
        }
    }

    @IBAction private func paymentButtonTouchUpInside(_ sender: Any) {
        guard let body = requestBodyPayment() else { return }
        createTransaction(body: body) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: Objc methods
    @objc private func doneButtonTouchUpInside() {
        phoneTextField.resignFirstResponder()
    }

    @objc private func returnButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Define
extension PaymentViewController {
    private struct Define {
        static var title: String = "Payment"
        static var cellName: String = String(describing: ItemTableViewCell.self)
        static var estimatedRowHeight: CGFloat = 120
        static var cornerRadius: CGFloat = 10
        static var borderWidth: CGFloat = 1.0
        static var borderColor: CGColor = UIColor.systemGray5.cgColor
    }
}

// MARK: Tableview Delegate, Datasource
extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: Define.cellName) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: TextField delegate
extension PaymentViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = textField.text.content.isEmpty ? .init(red: 0.89, green: 0.32, blue: 0.32, alpha: 1.00) : UIColor.systemGray5.cgColor
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case phoneTextField:
            phoneTextField.becomeFirstResponder()
            nameTextField.resignFirstResponder()
            addressTextField.resignFirstResponder()
        case nameTextField:
            nameTextField.becomeFirstResponder()
            phoneTextField.resignFirstResponder()
            addressTextField.resignFirstResponder()
        case addressTextField:
            phoneTextField.resignFirstResponder()
            nameTextField.resignFirstResponder()
            addressTextField.becomeFirstResponder()
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Get Apis
extension PaymentViewController {

    private func getApiUser() {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.getApiUser { [weak self] result in
            self?.dismissHUD()
            guard let this = self else { return }
            switch result {
            case .success(let res):
                this.nameTextField.text = res.userName
                this.phoneTextField.text = res.phoneNumber
                this.addressTextField.text = res.address
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        }
    }

    private func createTransaction(body: Payment, completion: @escaping (() -> Void)) {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.requestCreateTransaction(body: body) { [weak self] result in
            self?.dismissHUD()
            guard let this = self else { return }
            switch result {
            case .success(let response):
                this.alert(buttonTitle: "OK", title: "SUCCESS", msg: (response.data).content) {
                    completion()
                }
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        }
    }
}
