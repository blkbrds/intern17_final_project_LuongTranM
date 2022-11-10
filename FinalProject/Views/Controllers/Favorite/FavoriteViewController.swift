//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class FavoriteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: FavoriteViewModel?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        getFavoriteProduct()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteProduct()
    }

    // MARK: - Private methods
    private func configNavigation() {
        title = Define.title
    }

    private func configTableView() {
        let nib = UINib(nibName: Define.cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Define.cellName)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }

}

// MARK: - Define
extension FavoriteViewController {
    private struct Define {
        static var title: String = "Favorites"
        static var cellName: String = String(describing: FavoriteTableViewCell.self)
    }
}

// MARK: - TableView Delegate, Datasource
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: Define.cellName) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: Delegate
extension FavoriteViewController: FavoriteTableViewCellDelegate {
    func cell(_ cell: FavoriteTableViewCell, needPerform action: FavoriteTableViewCell.Action) {
        switch action {
        case .didTap:
            #warning("Handle later")
        }
    }
}

// MARK: Data
extension FavoriteViewController {

    func getFavoriteProduct() {
        guard let viewModel = viewModel else { return }
        viewModel.getFavoriteProduct { [weak self] done in
            if done {
                guard let this = self else { return }
                this.tableView.reloadData()
            } else {
                alert(msg: "No Data", completion: nil)
            }
        }
    }
}
