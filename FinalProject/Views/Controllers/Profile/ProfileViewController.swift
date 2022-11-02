//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet private weak var firstCharaterLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var purchaseTableView: UITableView!

    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configUI()
        configTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func configNavigation() {
        title = Define.title
    }

    private func configUI() {
        firstCharaterLabel.clipsToBounds = true
        firstCharaterLabel.layer.cornerRadius = firstCharaterLabel.frame.size.width / 2
    }

    private func configTableView() {
        let nib = UINib(nibName: Define.cellName, bundle: nil)
        purchaseTableView.register(nib, forCellReuseIdentifier: Define.cellName)
        purchaseTableView.separatorStyle = .none
        purchaseTableView.dataSource = self
        purchaseTableView.delegate = self
    }

}

extension ProfileViewController {
    private struct Define {
        static var title: String = "Profile"
        static var cellName: String = String(describing: HistoryTableViewCell.self)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.cellName) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
