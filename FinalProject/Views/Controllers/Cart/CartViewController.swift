//
//  CartViewController.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

final class CartViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var priceInfoView: UIView!
    @IBOutlet private weak var selectedItemLabel: UILabel!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var checkOutButton: UIButton!

    // MARK: - Properties
    var viewModel: CartViewModel?
    private var isShowViewDetail: Bool = true

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        configUI()
        getCart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Private methods
    private func configNavigation() {
        navigationItem.title = Define.title
        navigationItem.largeTitleDisplayMode = .never

        let backButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "chevron"), style: .plain, target: self, action: #selector(returnButtonTouchUpInside))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton

        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteButtonTouchUpInside))
        deleteButton.tintColor = .black
        navigationItem.rightBarButtonItem = deleteButton
    }

    private func  configTableView() {
        let nib = UINib(nibName: Define.cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Define.cellName)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configUI() {
        priceInfoView.layer.cornerRadius = Define.cornerRadius
        priceInfoView.layer.maskedCorners = Define.maskedCorners
        priceInfoView.layer.shadowColor = Define.shadowColor
        priceInfoView.layer.shadowOpacity = Define.shadowOpacity
        priceInfoView.layer.shadowOffset = Define.shadowOffset
        priceInfoView.layer.shadowRadius = Define.shadowRadius
        priceInfoView.layer.masksToBounds = false
        checkOutButton.layer.cornerRadius = Define.cornerRadius

        let tapView = UITapGestureRecognizer()
        tapView.addTarget(self, action: #selector(showHideViewDetail))
        priceInfoView.addGestureRecognizer(tapView)
    }

    private func updatePriceInfoView() {
        guard let viewModel = viewModel else { return }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let totalPrice = viewModel.totalPriceCarts()
        selectedItemLabel.text = "Item selected: \(viewModel.carts.count)"
        if let formattedTipAmount = formatter.string(from: totalPrice as NSNumber) {
            totalPriceLabel.text = "\(formattedTipAmount)"
        }
    }

    private func animationLoadTable() {
        UIView.transition(with: tableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }

    @IBAction func checkOutButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        var ordersId: [Int] = []
        for index in viewModel.carts {
            ordersId.append(index.id)
        }
        createTransaction(ordersId: ordersId, amount: viewModel.totalPriceCarts()) {
            self.navigationController?.popViewController(animated: false)
        }
    }

    // MARK: - Objc methods
    @objc private func showHideViewDetail(sender: UITapGestureRecognizer) {
        UIView.transition(with: checkOutButton, duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {
            self.checkOutButton.isHidden = self.isShowViewDetail
            self.isShowViewDetail = !self.isShowViewDetail
        })
    }

    @objc private func returnButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func deleteButtonTouchUpInside() {
        guard let viewModel = viewModel else { return }
        let refreshAlert = UIAlertController(title: "Delete", message: "Do you wanna delete all products in cart?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            viewModel.carts.removeAll()
            self.animationLoadTable()
          }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }
}

// MARK: - Define
extension CartViewController {
    private struct Define {
        static var title: String = "Cart"
        static var cellName: String = String(describing: CartTableViewCell.self)
        static var cornerRadius: CGFloat = 20
        static var shadowOffset: CGSize = CGSize(width: 3, height: 0)
        static var shadowOpacity: Float = 1
        static var shadowRadius: CGFloat = 3
        static var shadowColor: CGColor = UIColor.lightGray.cgColor
        static var maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

// MARK: - TableView Delegate, Datasource
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: Define.cellName) as? CartTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let viewModel = viewModel,
              let cart = viewModel.carts[safe: indexPath.row]  else { return UISwipeActionsConfiguration() }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let this = self else { return }
            this.deleteCart(orderId: cart.id)
            completionHandler(true)
        }
        delete.backgroundColor = .white

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: Delegate
extension CartViewController: CartTabeViewCellDelegate {
    func cell(cell: CartTableViewCell, needPerform action: CartTableViewCell.Action) {
        switch action {
        case .increase:
            guard let indexPath = tableView.indexPath(for: cell),
                  let viewModel = viewModel,
                  let cart = viewModel.carts[safe: indexPath.row] else { return }
            let numberItemCart = cart.quantity + 1
            updateCart(orderId: cart.id, quantity: numberItemCart)
        case .decrease:
            guard let indexPath = tableView.indexPath(for: cell),
                  let viewModel = viewModel,
                  let cart = viewModel.carts[safe: indexPath.row] else { return }
            let numberItemCart = cart.quantity - 1
            if numberItemCart != 0 {
                updateCart(orderId: cart.id, quantity: numberItemCart)
            } else {
                viewModel.carts.remove(at: indexPath.row)
                updateCart(orderId: cart.id, quantity: numberItemCart)
            }
        case .inputQuantity(let quantity):
            guard let indexPath = tableView.indexPath(for: cell),
                  let viewModel = viewModel,
                  let cart = viewModel.carts[safe: indexPath.row] else { return }
            updateCart(orderId: cart.id, quantity: quantity)
        }
        updatePriceInfoView()
    }
}

// MARK: Handle Apis
extension CartViewController {

    private func getCart() {
        guard let viewModel = viewModel else { return }
        viewModel.getApiCart { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.updatePriceInfoView()
                this.animationLoadTable()
            case .failure(let err):
                this.alert(msg: err.localizedDescription, completion: nil)
            }
        }
    }

    private func updateCart(orderId: Int, quantity: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.requestUpdateCart(orderId: orderId, quantity: quantity) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.getCart()
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        }
    }

    private func deleteCart(orderId: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.requestDeleteCart(orderId: orderId) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.getCart()
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        }
    }

    private func createTransaction(ordersId: [Int], amount: Int, completion: @escaping (() -> Void)) {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.requestCreateTransaction(orders: ordersId, amount: amount) { [weak self] result in
            self?.dismissHUD()
            guard let this = self else { return }
            switch result {
            case .success(let response):
                this.getCart()
                this.alert(buttonTitle: "OK", title: "SUCCESS", msg: (response.data).content) {
                    completion()
                }
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        }
    }
}
