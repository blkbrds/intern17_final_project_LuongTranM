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
    case createTransaction(body: Payment)
    case search
    case user
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
        case .search:
            return "product"
        case .user:
            return "infoUser"
        }
    }

    var method: Method {
        switch self {
        case .shop, .recommend, .popular, .cart, .search, .user:
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
        case .shop, .recommend, .popular, .cart, .addCart, .updateCart, .deleteCart, .createTransaction, .search, .user:
            return ApiManager.shared.getDefaultHTTPHeaders()
        }
    }

    var params: RequestParameters? {
        switch self {
        case .shop, .recommend, .popular, .cart, .deleteCart, .createTransaction, .search, .user:
            return [:]
        case .addCart(_, let quantity):
            return ["quantity": "\(quantity)"]
        case .updateCart(_, let quantity):
            return ["quantity": "\(quantity)"]
        }
    }

    var body: RequestBodys? {
        switch self {
        case .createTransaction(let body):
            return ["orders": body.orderIds,
                    "user_name": body.userName,
                    "user_phone": body.phoneNumber,
                    "address": body.address,
                    "amount": body.amount]
        default:
            return nil
        }
    }
}
