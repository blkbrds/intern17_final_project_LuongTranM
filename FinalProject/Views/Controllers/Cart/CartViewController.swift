//
//  CartViewController.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

final class CartViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var viewDetail: UIView!
    @IBOutlet private weak var selectedItemLabel: UILabel!
    @IBOutlet private weak var totalItemsLabel: UILabel!
    @IBOutlet private weak var checkOutButton: UIButton!

    var viewModel: CartViewModel?
    var totalCart: Int = 0
    var isShowViewDetail: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        guard let viewModel = viewModel else { return }
        viewModel.setData()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    private func configNavigation() {
        navigationItem.title = Define.title
        navigationItem.largeTitleDisplayMode = .never

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
        viewDetail.layer.cornerRadius = Define.cornerRadius
        viewDetail.layer.maskedCorners = Define.maskedCorners
        viewDetail.layer.shadowColor = Define.shadowColor
        viewDetail.layer.shadowOpacity = Define.shadowOpacity
        viewDetail.layer.shadowOffset = Define.shadowOffset
        viewDetail.layer.shadowRadius = Define.shadowRadius
        viewDetail.clipsToBounds = true
        viewDetail.layer.masksToBounds = false
        checkOutButton.layer.cornerRadius = Define.cornerRadius

        let tapView = UITapGestureRecognizer()
        tapView.addTarget(self, action: #selector(showHideViewDetail))
        viewDetail.addGestureRecognizer(tapView)
    }

    @objc private func showHideViewDetail(sender: UITapGestureRecognizer) {
        UIView.transition(with: checkOutButton, duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {
            self.checkOutButton.isHidden = self.isShowViewDetail
            self.isShowViewDetail = !self.isShowViewDetail
        })
    }

    private func handleTotalCart() {
        guard let viewModel = viewModel else { return }
        totalCart = viewModel.carts.reduce(0, { result, cart in
            result + cart.price
        })
    }

    private func animationLoadTable() {
        UIView.transition(with: tableView,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }

    @objc private func deleteButtonTouchUpInside() {
        guard let viewModel = viewModel else { return }
        let refreshAlert = UIAlertController(title: "Delete", message: "Do you wanna delete all products in cart?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            viewModel.carts.removeAll()
            self.animationLoadTable()
          }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }
}

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

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.carts.count
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
}

extension CartViewController: CartTabeViewCellDelegate {
    func cell(cell: CartTableViewCell, needPerform action: CartTableViewCell.Action) {
        switch action {
        case .increase(let id, let count):
            guard let index = tableView.indexPath(for: cell),
                  let viewModel = viewModel else { return }
            viewModel.updateCart(id: id, count: count, indexPath: index)
            tableView.reloadData()
        case .decrease(let id, let count):
            guard let index = tableView.indexPath(for: cell),
                  let viewModel = viewModel
            else { return }
            if count != 0 {
                viewModel.updateCart(id: id, count: count, indexPath: index)
                tableView.reloadData()
            } else {
                viewModel.carts.remove(at: index.row)
                animationLoadTable()
            }
        }
    }
}
