//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import Foundation

final class HomeViewModel {

    #warning("Handle Popular Product API")
    #warning("Handle Shop Images API")
    var images: [String] = [""]
    var currentCellIndex: Int = 0

    func viewModelForItem(at indexPath: IndexPath) -> SlideCollectionCellViewModel {
        return SlideCollectionCellViewModel(imageName: images[safe: indexPath.row].content, shopName: images[safe: indexPath.row].content)
    }
}
