//
//  APIManager.Login.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

enum LoginService {
    case login(email: String, password: String)
    case logout
}

extension LoginService: TargetType {
    var path: String {
        switch self {
        case .login:
            return "login"
        case .logout:
            return "logout"
        }
    }

    var method: Method {
        switch self {
        case .login, .logout:
            return .post
        }
    }

    var header: ReaquestHeaders? {
        switch self {
        case .login:
            return ["Content-type": "application/json"]
        case .logout:
            return ApiManager.shared.getDefaultHTTPHeaders()
        }
    }

    var params: RequestParameters? {
        switch self {
        case .login(let email, let password):
            return ["email": email,
                    "password": password]
        case .logout:
            return nil
        }
    }

    var body: RequestBodys? {
        switch self {
        case .login, .logout:
            return nil
        }
    }
}
