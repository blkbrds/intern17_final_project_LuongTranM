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
        getData()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
        priceInfoView.clipsToBounds = true
        priceInfoView.layer.masksToBounds = false
        checkOutButton.layer.cornerRadius = Define.cornerRadius

        updatePriceInfoView()

        let tapView = UITapGestureRecognizer()
        tapView.addTarget(self, action: #selector(showHideViewDetail))
        priceInfoView.addGestureRecognizer(tapView)
    }

    private func updatePriceInfoView() {
        guard let viewModel = viewModel else { return }
        let totalPrice = viewModel.totalPriceCarts()
        selectedItemLabel.text = "Item selected: \(viewModel.carts.count)"
        totalPriceLabel.text = "\(totalPrice)$"
    }

    private func getData() {
        guard let viewModel = viewModel else { return }
        viewModel.getData()
    }

    private func animationLoadTable() {
        UIView.transition(with: tableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
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
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let viewModel = viewModel else { return UISwipeActionsConfiguration() }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            tableView.beginUpdates()
            viewModel.carts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.updatePriceInfoView()
            tableView.endUpdates()
            completionHandler(true)
        }
        delete.backgroundColor = .white

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension CartViewController: CartTabeViewCellDelegate {
    func cell(cell: CartTableViewCell, needPerform action: CartTableViewCell.Action) {
        switch action {
        case .increase:
            guard let indexPath = tableView.indexPath(for: cell),
                  let viewModel = viewModel,
                  let cart = viewModel.carts[safe: indexPath.row] else { return }
            let numberItemCart = cart.quantity + 1
            viewModel.updateCart(count: numberItemCart, indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
        case .decrease:
            guard let indexPath = tableView.indexPath(for: cell),
                  let viewModel = viewModel,
                  let cart = viewModel.carts[safe: indexPath.row] else { return }
            let numberItemCart = cart.quantity - 1
            if numberItemCart != 0 {
                viewModel.updateCart(count: numberItemCart, indexPath: indexPath)
                tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                viewModel.carts.remove(at: indexPath.row)
                animationLoadTable()
            }
        }
        updatePriceInfoView()
    }
}
