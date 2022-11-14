//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation
import RealmSwift

final class DetailViewModel {

    var product: Product?

    init(product: Product?) {
        self.product = product
    }

    var favoriteProducts: [Product] = []
    var currentIndex: Int = 0

    func viewModelForItem(at indexPath: IndexPath) -> CarouselCollectionCellViewModel {
        return CarouselCollectionCellViewModel(image: (product?.images[safe: indexPath.row]?.image).content)
    }
}

extension DetailViewModel {

    func addFavoriteProduct(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                let product = Product(value: self.product ?? Product())
                realm.add(product)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }

    func deleteFavoriteProduct(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                let object = realm.objects(Product.self).filter("id = %@", self.product?.id as Any)
                realm.delete(object)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }

    func getFavoriteProduct() {
        do {
            let realm = try Realm()
            let result = realm.objects(Product.self)
            self.favoriteProducts = [Product](result)
        } catch {
            fatalError()
        }
    }

    func isFavorite(product: Product) -> Bool {
        getFavoriteProduct()
        for favoriteProduct in favoriteProducts where favoriteProduct.id == product.id {
            return true
        }
        return false
    }
}
