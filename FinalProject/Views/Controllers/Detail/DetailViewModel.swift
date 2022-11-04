//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class DetailViewModel {

    #warning("Handle data product")
    var product: Product?

    init(product: Product?) {
        self.product = product
    }

    var currentIndex: Int = 0

    func viewModelForItem(at indexPath: IndexPath) -> CarouselCollectionCellViewModel {
        return CarouselCollectionCellViewModel(image: (product?.images[safe: indexPath.row]?.image).content)
    }
}
