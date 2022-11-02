//
//  HomeViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: HomeViewModel?
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func configNavigation() {
        navigationItem.title = Define.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartButtonTouchUpInside))
        cartButton.tintColor = .black
        navigationItem.rightBarButtonItem = cartButton
    }

    private func configTableView() {
        let slideNib = UINib(nibName: Define.slideCell, bundle: Bundle.main)
        tableView.register(slideNib, forCellReuseIdentifier: Define.slideCell)

        let recommendCell = UINib(nibName: Define.recommendCell, bundle: Bundle.main)
        tableView.register(recommendCell, forCellReuseIdentifier: Define.recommendCell)

        let popularCell = UINib(nibName: Define.popularCell, bundle: Bundle.main)
        tableView.register(popularCell, forCellReuseIdentifier: Define.popularCell)

        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func cartButtonTouchUpInside() {
        let vc = CartViewController()
        vc.viewModel = CartViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    private struct Define {
        static var title: String = "Discover"
        static var insetDefault: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static var insetPopular: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static var insetRecommend: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        static var lineSpacingDefault: CGFloat = 0
        static var lineSpacingPopular: CGFloat = 10
        static var lineSpacingRecommend: CGFloat = 15
        static var slideCell: String = String(describing: SliderCell.self)
        static var recommendCell: String = String(describing: RecommendCell.self)
        static var popularCell: String = String(describing: PopularCell.self)
        static var timerIntervar: Double = 2.5
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.slideCell) as? SliderCell else {
                return UITableViewCell()
            }
            viewModel.cellType = .slide
            cell.selectionStyle = .none
            cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? SlideCellViewModel
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.recommendCell) as? RecommendCell else {
                return UITableViewCell()
            }
            viewModel.cellType = .recommend
            cell.selectionStyle = .none
            cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? RecommendCellViewModel
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.popularCell) as? PopularCell else {
                return UITableViewCell()
            }
            viewModel.cellType = .popular
            cell.selectionStyle = .none
            cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? PopularCellViewModel
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 300
        case 2:
            return 400
        default:
            return 0
        }
    }
}

// MARK: - APIs
extension HomeViewController {

    private func getData() {
        getProduct()
        getShop()
    }

    func getProduct() {
        guard let viewModel = viewModel else { return }
        viewModel.getProduct()
    }

    func getShop() {
        guard let viewModel = viewModel else { return }
        viewModel.getShop()
    }
}
