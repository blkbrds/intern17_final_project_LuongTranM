//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import Foundation

final class HomeViewModel {

    var images: [String] = ["beast", "drax", "groot", "storm", "thor", "wolverine"]
    var currentCellIndex: Int = 0

    func viewSlideForItem(at indexPath: IndexPath) -> SlideCollectionCellViewModel {
        let cellModel = SlideCollectionCellViewModel(imageName: images[indexPath.row], shopName: images[indexPath.row])
        return cellModel
    }

}
