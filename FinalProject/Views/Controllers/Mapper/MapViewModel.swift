//
//  MapViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 24/11/2022.
//

import Foundation
import CoreLocation

final class MapViewModel {

    var shop: Shop?
    var shops: [Shop] = []
    var resourceLocation: CLLocation?
    var destinationLocation: CLLocationCoordinate2D?

    init(shop: Shop? = nil) {
        self.shop = shop
    }

    func getApiShop(completion: @escaping Completion<[Shop]>) {
        ApiManager.shared.mainProvider.request(target: .shop, model: ShopResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ShopResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.shops = Array(response.data).filter { $0.id != self.shop?.id }
                completion(.success(self.shops))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
