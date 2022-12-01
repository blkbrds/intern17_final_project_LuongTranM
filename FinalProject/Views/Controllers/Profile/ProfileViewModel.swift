//
//  ProfileViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class ProfileViewModel {

    var orderTrans: [Cart] = []

    #warning("Dummy Data")
    func getOrder() {
        let p1 = Cart(id: 5,
                      userId: 20,
                      productId: 37,
                      productName: "Santal Royal 2",
                      quantity: 2,
                      price: 260,
                      status: 1,
                      productImage: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png")
        let p2 = Cart(id: 5,
                      userId: 20,
                      productId: 37,
                      productName: "Santal Royal 2",
                      quantity: 2,
                      price: 260,
                      status: 1,
                      productImage: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png")
        let p3 = Cart(id: 5,
                      userId: 20,
                      productId: 37,
                      productName: "Santal Royal 2",
                      quantity: 2,
                      price: 260,
                      status: 1,
                      productImage: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png")

        orderTrans.append(contentsOf: [p1, p2, p3])
    }

    func getApiUser(completion: @escaping Completion<User>) {
        ApiManager.shared.mainProvider.request(target: .user, model: UserResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? UserResponse else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(response.data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func requestLogout(completion: @escaping Completion<MessageResponse>) {
        ApiManager.shared.loginProvider.request(target: .logout, model: MessageResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? MessageResponse else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(response))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func numberOfRows(in section: Int) -> Int {
        return orderTrans.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> HistoryTableCellViewModel {
        guard let orderTran = orderTrans[safe: indexPath.row] else { return HistoryTableCellViewModel(orderTrans: nil) }
        return HistoryTableCellViewModel(orderTrans: orderTran)
    }
}
