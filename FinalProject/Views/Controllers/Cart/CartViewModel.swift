//
//  CartViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation

final class CartViewModel {

    var carts: [Cart] = []
    var totalPrice: Int = 0

    func getApiCart(completion: @escaping Completion<[Cart]>) {
        ApiManager.shared.mainProvider.request(target: .cart, model: CartResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? CartResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.carts = response.data ?? []
                completion(.success(self.carts))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func totalPriceCarts() -> Int {
        var total: Int = 0
        for cart in carts {
            total += cart.quantity * cart.price
        }
        return total
    }

    func requestUpdateCart(orderId: Int, quantity: Int, completion: @escaping Completion<MessageResponse>) {
        ApiManager.shared.mainProvider.request(target: .updateCart(id: orderId, quantity: quantity), model: MessageResponse.self) { result in
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

    func requestDeleteCart(orderId: Int, completion: @escaping Completion<MessageResponse>) {
        ApiManager.shared.mainProvider.request(target: .deleteCart(id: orderId), model: MessageResponse.self) { result in
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

    func requestCreateTransaction(orders: [Int], amount: Int, completion: @escaping Completion<MessageResponse>) {
        ApiManager.shared.mainProvider.request(target: .createTransaction(orders: orders, amount: amount), model: MessageResponse.self) { result in
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
        return carts.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> CartCellViewModel {
        let cellViewModel = CartCellViewModel(cart: carts[indexPath.row])
        return cellViewModel
    }
}
