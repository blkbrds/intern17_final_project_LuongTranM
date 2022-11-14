//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import Foundation

final class HomeViewModel {

    enum CellType {
        case slide
        case recommend
        case popular
    }

    var cellType: CellType = .slide
    var shops: [Shop] = []
    var popularProducts: [Product] = []
    var recommendProducts: [Product] = []

    func numberOfRows(in section: Int) -> Int {
        var index = 0
        if !shops.isEmpty {
            index += 1
        }
        if recommendProducts.count != 0 {
            index += 1
        }
        if popularProducts.count != 0 {
            index += 1
        }
        return index
    }

    func getApiPopularProduct(completion: @escaping Completion<[Product]>) {
        ApiManager.shared.mainProvider.request(target: .popular, model: ProductResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ProductResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.popularProducts = Array(response.data)
                completion(.success(self.popularProducts))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func getApiRecommendProduct(completion: @escaping Completion<[Product]>) {
        ApiManager.shared.mainProvider.request(target: .recommend, model: ProductResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ProductResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.recommendProducts = Array(response.data)
                completion(.success(self.recommendProducts))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func getApiShop(completion: @escaping Completion<[Shop]>) {
        ApiManager.shared.mainProvider.request(target: .shop, model: ShopResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ShopResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.shops = Array(response.data)
                completion(.success(self.shops))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> Any? {
        switch cellType {
        case .slide:
            return SlideCellViewModel(shops: shops)
        case .recommend:
            return RecommendCellViewModel(products: recommendProducts)
        case .popular:
            return PopularCellViewModel(products: popularProducts)
        }
    }

}
