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
    var currentCellIndex: Int = 0
    var products: [Product]?

    func testAPIProduct(completion: @escaping Completion<[Product]>) {
        ApiManager.shared.mainProvider.request(target: .popular, model: ProductResponse.self) {
            result in
            switch result {
            case .success(let response):
                guard let response = response as? ProductResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.products = response.data
                completion(.success(self.products ?? []))
            case .failure(let err):
                print(err)
                completion(.failure(err))
            }
        }
    }

//    func a(usr: String, pw: String) {
//        ApiManager.shared.loginProvider.request(target: .testAPI(usr: <#T##String#>, pw: <#T##String#>), model: <#T##(Decodable & Encodable).Protocol#>, completion: <#T##APICompletion##APICompletion##(APIResult) -> Void#>)
//    }

    func getShop() {
        let p1 = Shop(id: 1,
                      nameShop: "Guarlain",
                      address: "abc",
                      phoneNumber: "012345566",
                      emailShop: "123",
                      imageShop: "http://localhost:8000/storage/shop/1666972408_guerlain_logo.png",
                      description: "abc")
        let p2 = Shop(id: 2,
                      nameShop: "Adidas",
                      address: "abc",
                      phoneNumber: "012345566",
                      emailShop: "123",
                      imageShop: "http://localhost:8000/storage/shop/1666968564_adidas_logo.png",
                      description: "abc")
        let p3 = Shop(id: 3,
                      nameShop: "Gucci",
                      address: "abc",
                      phoneNumber: "012345566",
                      emailShop: "123",
                      imageShop: "http://localhost:8000/storage/shop/1666970628_gucci_logo.jpeg",
                      description: "abc")

        shops.append(contentsOf: [p1, p2, p3])
    }

    func viewModelForItem(at indexPath: IndexPath) -> Any? {
        switch cellType {
        case .slide:
            return SlideCellViewModel(shops: shops)
        case .recommend:
            return RecommendCellViewModel(products: products)
        case .popular:
            guard let products = products else { return PopularCellViewModel(products: []) }
            return PopularCellViewModel(products: products)
        }
    }

}
