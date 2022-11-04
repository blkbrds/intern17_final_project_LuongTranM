//
//  SearchViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Outles
    @IBOutlet private weak var searchCollectionView: UICollectionView!

    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)

    var viewModel: SearchViewModel?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configCollectionView()
        configSearchController()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Private methods
    private func configNavigation() {
        navigationItem.title = Define.title
    }

    private func configCollectionView() {
        let searchNib = UINib(nibName: Define.cellName, bundle: Bundle.main)
        searchCollectionView.register(searchNib, forCellWithReuseIdentifier: Define.cellName)
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }

    private func configSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.scopeButtonTitles = ["Product", "Shop"]
        searchController.searchBar.placeholder = "Searching..."
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Define
extension SearchViewController {
    private struct Define {
        static var title: String = "Search"
        static var cellName: String = String(describing: SearchCollectionViewCell.self)
        static var insetSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

// MARK: - CollectionView Delegate, Datasource
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    #warning("Handle Cell")
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewDetailForItem(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 15, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Define.insetSection
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {

    #warning("Handle search")
    func updateSearchResults(for searchController: UISearchController) {
        guard let viewModel = viewModel else { return }
        let scopeButton = searchController.searchBar.scopeButtonTitles?[searchController.searchBar.selectedScopeButtonIndex]
        let searchText = (searchController.searchBar.text).content
        if !searchText.isEmpty {
            viewModel.searching = true
            viewModel.searchProducts.removeAll()
            for product in viewModel.products {
                if product.name.lowercased().contains(searchText.lowercased()) &&
                    (scopeButton == "Product") {
                    viewModel.searchProducts.append(product)
                } else if product.category.shop.nameShop.lowercased().contains(searchText.lowercased()) &&
                            (scopeButton == "Shop") {
                    viewModel.searchProducts.append(product)
                }
            }
        } else {
            if viewModel.scopeButtonPress {
                viewModel.searchProducts.removeAll()
                let scopeButton = searchController.searchBar.scopeButtonTitles?[searchController.searchBar.selectedScopeButtonIndex]
                if !(scopeButton?.isEmpty ?? false) {
                    viewModel.searchProducts.removeAll()
                } else { }
                viewModel.searching = false
                searchCollectionView.reloadData()
            } else {
                viewModel.searching = false
                viewModel.searchProducts.removeAll()
                viewModel.searchProducts = viewModel.products
            }
        }
        searchCollectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let viewModel = viewModel else { return }
        viewModel.searching = false
        viewModel.searchProducts.removeAll()
        searchCollectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.scopeButtonPress = true
        let scopeButton = searchController.searchBar.scopeButtonTitles?[searchController.searchBar.selectedScopeButtonIndex]
        for product in viewModel.products {
            if !(scopeButton?.isEmpty ?? false) {
                viewModel.searchProducts.append(product)
            } else { }
        }
        searchCollectionView.reloadData()
    }
}

// MARK: - APIs
extension SearchViewController {

    private func getData() {
        getProduct()
    }

    func getProduct() {
        guard let viewModel = viewModel else { return }
        viewModel.getProduct()
    }
}
