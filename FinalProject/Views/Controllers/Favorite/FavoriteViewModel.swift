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

    func deleteFavorite(id: Int, at indexPath: IndexPath, completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                let object = realm.objects(Product.self).filter("id = %@", id as Any)
                realm.delete(object)
            }
            completion(true)
        } catch {
            completion(false)
        }
        favoriteProucts?.remove(at: indexPath.row)
    }

    func numberOfRows(in section: Int) -> Int {
        guard let favoriteProucts = favoriteProucts else { return 0 }
        return favoriteProucts.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> FavoriteTableCellViewModel {
        return FavoriteTableCellViewModel(product: favoriteProucts?[safe: indexPath.row])
    }
}
