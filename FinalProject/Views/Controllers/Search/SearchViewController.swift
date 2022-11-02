//
//  SearchViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet private weak var searchCollectionView: UICollectionView!

    private let searchController = UISearchController(searchResultsController: nil)

    var viewModel: SearchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configCollectionView()
        configSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

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
        searchController.searchBar.scopeButtonTitles = [ "Product", "Shop"]
        searchController.searchBar.placeholder = "Searching..."
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension SearchViewController {
    private struct Define {
        static var title: String = "Search"
        static var cellName: String = String(describing: SearchCollectionViewCell.self)
        static var insetSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    #warning("Handle Cell")
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = DetailViewModel()
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

    func updateSearchResults(for searchController: UISearchController) {
        searchCollectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchCollectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchCollectionView.reloadData()
    }
}
