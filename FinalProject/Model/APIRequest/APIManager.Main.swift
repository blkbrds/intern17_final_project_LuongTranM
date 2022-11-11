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
        case .addCart(id: let id, quantity: _):
            return "cart/add/\(id)"
        case .updateCart(id: let id, quantity: _):
            return "cart/update/\(id)"
        case .deleteCart(id: let id):
            return "cart/delete/\(id)"
        }
    }

    var method: Method {
        switch self {
        case .shop, .recommend, .popular, .cart:
            return .get
        case .addCart:
            return .post
        case .updateCart:
            return .patch
        case .deleteCart:
            return .delete
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .shop, .recommend, .popular, .cart, .addCart, .updateCart, .deleteCart:
            return ApiManager.shared.getDefaultHTTPHeaders()
        }
    }

    var params: RequestParameters? {
        switch self {
        case .shop, .recommend, .popular, .cart, .deleteCart:
            return [:]
        case .addCart(id: _, quantity: let quantity):
            return ["quantity": "\(quantity)"]
        case .updateCart(id: _, quantity: let quantity):
            return ["quantity": "\(quantity)"]
        }
    }
}
