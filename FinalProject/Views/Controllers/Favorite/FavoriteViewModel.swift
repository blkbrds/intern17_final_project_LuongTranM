//
//  FavoriteViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class FavoriteViewModel {

    #warning("Handle Data Favorite")
    var doVat: [String] = ["Tivi", "Dao", "Kéo", "Xe", "Chén", "Bát", "Kèn", "Búa", "Đinh"]

    func viewModelForItem(at indexPath: IndexPath) -> FavoriteTableCellViewModel {
        let cellModel = FavoriteTableCellViewModel(name: doVat[indexPath.row])
        return cellModel
    }
}
