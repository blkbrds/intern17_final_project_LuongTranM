//
//  APIManager.Login.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

enum LoginService {
    case login(email: String, password: String)
}

extension LoginService: TargetType {
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }

    var method: Method {
        switch self {
        case .login:
            return .post
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .login:
            return ApiManager.shared.defaultHTTPHeaders
        }
    }

    var params: RequestParameters? {
        switch self {
        case .login(email: let email, password: let password):
            return ["email": email,
                    "password": password]
        }
    }
}
