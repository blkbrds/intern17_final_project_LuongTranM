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
        }
    }

    var method: Method {
        switch self {
        case .shop, .recommend, .popular:
            return .get
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .shop, .recommend, .popular:
            return ApiManager.shared.getDefaultHTTPHeaders()
        }
    }

    var params: RequestParameters? {
        switch self {
        case .shop, .recommend, .popular:
            return [:]
        }
    }
}
