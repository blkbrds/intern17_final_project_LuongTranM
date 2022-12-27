//
//  HomeViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: HomeViewModel?
    private var homeError: APIError?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTableView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
        setPrefersLargeTitles(type: .discovery)
    }

    // MARK: - Private methods
    private func configNavigation() {
        setTitleNavigation(type: .discovery)
        setRightBarButton(imageString: "cart", tintColor: .red, action: #selector(cartButtonTouchUpInside))
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

    // MARK: - Objc methods
    @objc private func cartButtonTouchUpInside() {
        let vc = CartViewController()
        vc.viewModel = CartViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Define
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

// MARK: - TableView Delegate, Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
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
            cell.delegate = self
            cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? RecommendCellViewModel
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.popularCell) as? PopularCell else {
                return UITableViewCell()
            }
            viewModel.cellType = .popular
            cell.selectionStyle = .none
            cell.delegate = self
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
            return 220
        case 2:
            return 400
        default:
            return 0
        }
    }
}

// MARK: - Delegate
extension HomeViewController: PopularCellDelegate {

    func cell(cell: PopularCell, needPerform action: PopularCell.Action) {
        switch action {
        case .didTap(let product):
            let vc = DetailViewController()
            vc.viewModel = DetailViewModel(product: product)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: RecommendCellDelegate {

    func cell(cell: RecommendCell, needPerform action: RecommendCell.Action) {
        switch action {
        case .didTap(let product):
            let vc = DetailViewController()
            vc.viewModel = DetailViewModel(product: product)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - APIs
extension HomeViewController {

    private func getData() {
        let dispatch = DispatchGroup()

        showHUD()

        dispatch.enter()
        getShop {
            dispatch.leave()
        }

        dispatch.enter()
        getRecommendProduct {
            dispatch.leave()
        }

        dispatch.enter()
        getPouplarProduct {
            dispatch.leave()
        }

        dispatch.notify(queue: .main) { [weak self] in
            self?.dismissHUD()
            guard let this = self else { return }
            if this.homeError != nil {
                this.alert(msg: (this.homeError?.localizedDescription).content, completion: nil)
            } else {
                this.tableView.reloadData()
            }
        }
    }

    private func getPouplarProduct(completion: @escaping () -> Void) {
        guard let viewModel = viewModel else { return }
        viewModel.getApiPopularProduct { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                completion()
            case .failure(let error):
                this.checkError(error: error)
                completion()
            }
        }
    }

    private func getRecommendProduct(completion: @escaping () -> Void) {
        guard let viewModel = viewModel else { return }
        viewModel.getApiRecommendProduct { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                completion()
            case .failure(let error):
                this.checkError(error: error)
                completion()
            }
        }
    }

    private func getShop(completion: @escaping () -> Void) {
        guard let viewModel = viewModel else { return }
        viewModel.getApiShop { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                completion()
            case .failure(let error):
                this.checkError(error: error)
                completion()
            }
        }
    }

    private func checkError(error: APIError) {
        guard homeError == nil else {
            return
        }
        homeError = error
    }
}
