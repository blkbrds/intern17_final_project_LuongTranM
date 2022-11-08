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

    func numberOfPage() -> Int {
        return shops.count >= Define.numberOfPage ? Define.numberOfPage : shops.count
    }

    func numberOfItems(in section: Int) -> Int {
        return shops.count >= Define.numberOfPage ? Define.numberOfPage : shops.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> SlideCollectionCellViewModel {
        guard let shop = shops[safe: indexPath.row] else { return SlideCollectionCellViewModel(shop: nil) }
        return SlideCollectionCellViewModel(shop: shop)
    }
}

extension SlideCellViewModel {
    private struct Define {
        static let numberOfPage: Int = 3
    }
}
