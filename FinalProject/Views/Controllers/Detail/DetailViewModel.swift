//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class DetailViewModel {
    #warning("Handle data product")
    var images: [String] = ["https://product.hstatic.net/1000075078/product/1653291204_hi-tea-vai_0e8376fb3eec4127ba33aa47b8d2c723_large.jpg",
                            "https://product.hstatic.net/1000075078/product/1639377738_ca-phe-sua-da_721d7068e01045b99542243abe413080_large.jpg"]
    var currentCellIndex: Int = 0

    func viewCarouselForItem(at indexPath: IndexPath) -> CarouselCollectionCellViewModel {
        return CarouselCollectionCellViewModel(image: images[safe: indexPath.row].content)
    }
}
