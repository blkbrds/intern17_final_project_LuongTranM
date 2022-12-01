//
//  TransactionViewController.swift
//  FinalProject
//
//  Created by luong.tran on 28/11/2022.
//

import UIKit

final class TransactionViewController: UIViewController {

    // MARK: Oulets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Properties
    var viewModel: TransactionViewModel?

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        getTransaction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: Private methods
    private func configNavigation() {
        navigationItem.title = "Orders"

        let backButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "chevron"), style: .plain, target: self, action: #selector(returnButtonTouchUpInside))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }

    private func configTableView() {
        let nibHeader = UINib(nibName: Define.headerView, bundle: nil)
        tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: Define.headerView)
        let nib = UINib(nibName: Define.cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Define.cellName)
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: Objc method
    @objc private func returnButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Define
extension TransactionViewController {
    private struct Define {
        static var headerView: String = String(describing: TransactionHeaderView.self)
        static var cellName: String = String(describing: TransactionTableViewCell.self)
    }
}

// MARK: Table View Delegate, Datasource
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.cellName, for: indexPath) as? TransactionTableViewCell,
              let viewModel = viewModel else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Define.headerView) as? TransactionHeaderView,
              let viewModel = viewModel else {
            return UIView()
        }
        headerView.layer.cornerRadius = 10
        headerView.layer.borderWidth = 1
        headerView.viewModel = viewModel.viewModelForHeader(in: section)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: get APIs
extension TransactionViewController {

    private func getTransaction() {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.test(startDay: "2022-11-14", endDay: "2022-11-14") { [weak self] result in
            self?.dismissHUD()
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let err):
                this.alert(msg: err.localizedDescription, completion: nil)
            }
        }
    }
}
