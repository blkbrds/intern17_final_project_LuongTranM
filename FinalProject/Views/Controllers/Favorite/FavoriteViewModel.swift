//
//  FavoriteViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation
import RealmSwift

final class FavoriteViewModel {

    var favoriteProucts: [Product]?

    func getFavoriteProduct(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Product.self)
            favoriteProucts = Array(results)
            completion(true)
        } catch {
            completion(false)
        }
    }

    func numberOfRows(in section: Int) -> Int {
        guard let favoriteProucts = favoriteProucts else { return 0 }
        return favoriteProucts.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> FavoriteTableCellViewModel {
        return FavoriteTableCellViewModel(product: favoriteProucts?[safe: indexPath.row])
    }
}
