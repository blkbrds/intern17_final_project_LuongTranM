//
//  APIManager.Main.swift
//  FinalProject
//
//  Created by luong.tran on 04/11/2022.
//

import Foundation

enum MainService {
    case popular
}

extension MainService: TargetType {
    var path: String {
        switch self {
        case .popular:
            return "product/new"
        }
    }

    var method: Method {
        switch self {
        case .popular:
            return .get
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .popular:
            return ApiManager.shared.defaultHTTPHeaders
        }
    }

    var params: RequestParameters? {
        switch self {
        case .popular:
            return [:]
        }
    }
}
