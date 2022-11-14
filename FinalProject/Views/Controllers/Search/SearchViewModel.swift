//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class SearchViewModel {

    var products: [Product] = []
    var searchProducts: [Product] = []
    var searching: Bool = false
    var scopeButtonPress: Bool = false

    #warning("Dummy Data")
    func getApiProduct(completion: @escaping Completion<[Product]>) {
        ApiManager.shared.mainProvider.request(target: .search, model: ProductResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ProductResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.products = response.data
                completion(.success(self.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfItems(in section: Int) -> Int {
        if searching || scopeButtonPress {
            return searchProducts.count
        } else {
            return 0
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> SearchCollectionCellViewModel {
        if searching || scopeButtonPress {
            guard let product = searchProducts[safe: indexPath.row] else { return SearchCollectionCellViewModel(product: nil) }
            return SearchCollectionCellViewModel(product: product)
        } else {
            guard let product = products[safe: indexPath.row] else { return SearchCollectionCellViewModel(product: nil) }
            return SearchCollectionCellViewModel(product: product)
        }
    }

    func viewDetailForItem(at indexPath: IndexPath) -> DetailViewModel {
        if searching || scopeButtonPress {
            guard let product = searchProducts[safe: indexPath.row] else { return DetailViewModel(product: nil) }
            return DetailViewModel(product: product)
        } else {
            guard let product = products[safe: indexPath.row] else { return DetailViewModel(product: nil) }
            return DetailViewModel(product: product)
        }
    }
}
