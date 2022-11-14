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

    func numberOfItems(in section: Int) -> Int {
        if searching || scopeButtonPress {
            return searchProducts.count
        } else {
            return products.count
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
