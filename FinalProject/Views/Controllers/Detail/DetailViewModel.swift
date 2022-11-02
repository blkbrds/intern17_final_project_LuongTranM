//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class DetailViewModel {
    var images: [String] = ["beast", "drax", "groot", "storm", "thor", "wolverine"]
    var currentCellIndex: Int = 0

    func viewSlideForItem(at indexPath: IndexPath) -> CarouselCollectionCellViewModel {
        return CarouselCollectionCellViewModel(image: images[safe: indexPath.row].content)
    }
}
