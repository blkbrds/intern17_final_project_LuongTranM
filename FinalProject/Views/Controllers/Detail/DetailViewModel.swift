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

    var favoriteProducts: [Product]?
    var currentIndex: Int = 0
    var isFav: Bool = false

    func viewModelForItem(at indexPath: IndexPath) -> CarouselCollectionCellViewModel {
        return CarouselCollectionCellViewModel(image: (product?.images[safe: indexPath.row]?.image).content)
    }
}

extension DetailViewModel {

//    func isFavorite() -> Bool {
//        do {
//            let realm = try Realm()
//            let result = realm.objects(Product.self).first(where: { $0.id == product?.id })
//            return result != nil
//        } catch {
//            return false
//        }
//    }

    func addFavoriteProduct(completion: (Bool) -> Void) {
//        do {
//            let realm = try Realm()
//            var object = Product()
//            guard let product = product else {
//                completion(false)
//                return
//            }
//            object = product
//            try realm.write {
//                realm.add(object)
//            }
//            completion(true)
//        } catch {
//            completion(false)
//        }
    }

    func deleteFavoriteProduct(completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            guard let results = realm.objects(Product.self).first(where: { $0.id == product?.id }) else { return }
            do {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    try? realm.write {
                        realm.delete(results)
                    }
                    completion(true)
                }
            } catch { }
        } catch {
            completion(false)
        }
    }

    func fetchData(completion: (Bool) -> Void) {
//        do {
//            let realm = try Realm()
//            let results = realm.objects(Product.self)
//            print(Array(results))
//            completion(true)
//        } catch {
//            completion(false)
//        }
    }
}
