//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit
import RealmSwift

final class FavoriteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: FavoriteViewModel?
    private var notificationToken: NotificationToken?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        setUpObserve()
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
            guard let viewModel = viewModel,
                  let indexPath = tableView.indexPath(for: cell),
                  let product = viewModel.favoriteProucts?[safe: indexPath.row] else { return }
            tableView.beginUpdates()
            viewModel.deleteFavorite(id: product.id, at: indexPath) { [weak self] (done) in
                guard let this = self else { return }
                if !done {
                    this.alert(msg: "Can't Delete Data", completion: nil)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }
}

// MARK: Data
extension FavoriteViewController {

    private func setUpObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Product.self).observe({ [weak self] (_) in
                guard let this = self else { return }
                this.getFavoriteProduct()
            })
        } catch {
            alert(msg: "Can't reload data", completion: nil)
        }
    }

    private func getFavoriteProduct() {
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
