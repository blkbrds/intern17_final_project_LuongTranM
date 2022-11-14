//
//  APIManager.Main.swift
//  FinalProject
//
//  Created by luong.tran on 04/11/2022.
//

import Foundation

enum MainService {
    case popular
    case recommend
    case shop
    case cart
    case addCart(id: Int, quantity: Int)
    case updateCart(id: Int, quantity: Int)
    case deleteCart(id: Int)
    case createTransaction(orders: [Int], amount: Int)
}

extension MainService: TargetType {
    var path: String {
        switch self {
        case .shop:
            return "shop"
        case .recommend:
            return "product/random"
        case .popular:
            return "product/new"
        case .cart:
            return "cart"
        case .addCart(let id, _):
            return "cart/add/\(id)"
        case .updateCart(let id, _):
            return "cart/update/\(id)"
        case .deleteCart(let id):
            return "cart/delete/\(id)"
        case .createTransaction:
            return "transaction/create"
        }
    }

    var method: Method {
        switch self {
        case .shop, .recommend, .popular, .cart:
            return .get
        case .addCart, .createTransaction:
            return .post
        case .updateCart:
            return .patch
        case .deleteCart:
            return .delete
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .shop, .recommend, .popular, .cart, .addCart, .updateCart, .deleteCart, .createTransaction:
            return ApiManager.shared.getDefaultHTTPHeaders()
        }
    }

    var params: RequestParameters? {
        switch self {
        case .shop, .recommend, .popular, .cart, .deleteCart:
            return [:]
        case .addCart(_, let quantity):
            return ["quantity": "\(quantity)"]
        case .updateCart(_, let quantity):
            return ["quantity": "\(quantity)"]
        case .createTransaction(let orders, let amount):
            return ["orders": "\(orders)",
                    "user_name": "Minh Lương",
                    "user_phone": "0123456789",
                    "address": "ĐN",
                    "amount": "\(amount)"]
        }
    }
}
