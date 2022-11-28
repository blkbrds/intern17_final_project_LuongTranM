//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var firstCharaterLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var purchaseTableView: UITableView!

    // MARK: - Properties
    var viewModel: ProfileViewModel?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configUI()
        configTableView()
        getUserInfomation()
        getDummyData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Private methods
    private func configNavigation() {
        setTitleNavigation(type: .profile)
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

    // MARK: - Action methods
    @IBAction private func logOutButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.requestLogout { [weak self] result in
            self?.dismissHUD()
            guard let this = self else { return }
            switch result {
            case .success:
                Session.shared.token = ""
                AppDelegate.shared.setRoot(rootType: .login)
            case .failure(let err):
                this.alert(msg: err.localizedDescription, completion: nil)
            }
        }
    }

    @IBAction private func infoButtonTouchUpInside(_ sender: Any) {
        #warning("Handle Info")
    }

    @IBAction private func orderButtonTouchUpInside(_ sender: Any) {
        #warning("Handle Order")
    }

    @IBAction private func settingButtonTouchUpInside(_ sender: Any) {
        #warning("Handle Setting")
    }
}

// MARK: - Define
extension ProfileViewController {
    private struct Define {
        static var title: String = "Profile"
        static var cellName: String = String(describing: HistoryTableViewCell.self)
    }
}

// MARK: - TableView Delegate, Datasource
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: Define.cellName) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: getApis
extension ProfileViewController {

    private func getDummyData() {
        guard let viewModel = viewModel else { return }
        viewModel.getOrder()
    }

    private func getUserInfomation() {
        guard let viewModel = viewModel else { return }
        showHUD()
        viewModel.getApiUser { [weak self] result in
            guard let this = self else { return }
            self?.dismissHUD()
            switch result {
            case .success(let user):
                this.firstCharaterLabel.text = user.userName.uppercased().first?.description
                this.usernameLabel.text = user.userName
                this.emailLabel.text = user.email
            case .failure(let error):
                this.alert(msg: error.localizedDescription, completion: nil)
            }
        }
    }
}
