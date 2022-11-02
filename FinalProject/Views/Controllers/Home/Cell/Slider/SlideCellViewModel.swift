//
//  SlideCellViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation

final class SlideCellViewModel {

    var shops: [Shop]
    var currentIndex: Int = 0

    init(shops: [Shop]) {
        self.shops = shops
    }

    func numberOfItems(in section: Int) -> Int {
        return shops.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> SlideCollectionCellViewModel {
        guard let shop = shops[safe: indexPath.row] else { return SlideCollectionCellViewModel(shop: nil) }
        return SlideCollectionCellViewModel(shop: shop)
    }
}
