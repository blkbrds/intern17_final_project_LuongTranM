//
//  APIManager.Login.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

enum LoginService {
    case testAPI
}

extension LoginService: TargetType {
    var path: String {
        switch self {
        case .testAPI:
            return "/weather"
        }
    }

    var method: Method {
        switch self {
        case .testAPI:
            return .get
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .testAPI:
            return ApiManager.shared.defaultHTTPHeaders
        }
    }

    var params: RequestParameters? {
        switch self {
        case .testAPI:
            return [
                "appid": "29f841fc056921a0ca0cf95542d2f5c0",
                "units": "metric",
                "q": "DaNang"]
        }
    }
}
