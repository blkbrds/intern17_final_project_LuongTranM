//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class FavoriteViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: FavoriteViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
    }

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

extension FavoriteViewController {
    private struct Define {
        static var title: String = "Favorites"
        static var cellName: String = String(describing: FavoriteTableViewCell.self)
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.items.count
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

extension FavoriteViewController: FavoriteTableViewCellDelegate {
    func cell(cell: FavoriteTableViewCell, needPerform action: FavoriteTableViewCell.Action) {
        switch action {
        case .didTap:
            guard let viewModel = viewModel,
                  let index = tableView.indexPath(for: cell) else { return }
            viewModel.items.remove(at: index.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [index], with: .left)
            tableView.endUpdates()
        }
    }
}
