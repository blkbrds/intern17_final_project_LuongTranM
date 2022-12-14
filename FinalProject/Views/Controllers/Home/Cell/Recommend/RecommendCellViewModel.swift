//
//  RecommendCellViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation

final class RecommendCellViewModel {

    var products: [Product]

    init(products: [Product]) {
        self.products = products
    }

    func numberOfItems(in section: Int) -> Int {
        return products.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> RecommendCollectionCellViewModel {
        guard let product = products[safe: indexPath.row] else { return RecommendCollectionCellViewModel(product: nil) }
        return RecommendCollectionCellViewModel(product: product)
    }
}
