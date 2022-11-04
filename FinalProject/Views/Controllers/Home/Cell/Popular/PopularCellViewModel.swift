//
//  PopularCellViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation

final class PopularCellViewModel {

    var products: [Product]

    init(products: [Product]) {
        self.products = products
    }

    func numberOfItems(in section: Int) -> Int {
        return products.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> PopularCollectionCellViewModel {
        guard let product = products[safe: indexPath.row] else { return PopularCollectionCellViewModel(product: nil) }
        return PopularCollectionCellViewModel(product: product)
    }

    func viewDetailForItem(at indexPath: IndexPath) -> DetailViewModel {
        guard let product = products[safe: indexPath.row] else { return DetailViewModel(product: nil) }
        return DetailViewModel(product: product)
    }
}
