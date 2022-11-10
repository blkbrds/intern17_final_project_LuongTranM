//
//  APIManager.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

typealias APICompletion = (APIResult) -> Void
typealias Completion<Value> = (Result<Value>) -> Void

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias ReaquestHeaders = [String: String]
typealias RequestParameters = [String: String]

enum Result<Value> {
    case success(Value)
    case failure(APIError)
}

enum APIResult {
    case success(Codable)
    case failure(APIError)
}

enum APIError: Error {

    case noData
    case invalidResponse
    case badRequest
    case parseError
    case noInternet
    case unknown

    var localizedDescription: String {
        switch self {
        case .noInternet:
            return "No Internet"
        case .noData:
            return "No data"
        case .invalidResponse:
            return "Invalid Response"
        case .badRequest:
            return "Bad request"
        case .parseError:
            return "Parse Json Error"
        case .unknown:
            return "Unknown Error"
        }
    }
}

class ApiManager {

    static var shared: ApiManager = ApiManager()

    func getDefaultHTTPHeaders() -> [String: String] {
        return [
            "Content-type": "application/json",
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3YxL3VzZXIvbG9naW4iLCJpYXQiOjE2Njc5Nzk0MzAsImV4cCI6MTY5OTUxNTQzMCwibmJmIjoxNjY3OTc5NDMwLCJqdGkiOiI1eDNGZVNVc2xCaXJ5Qmk3Iiwic3ViIjoiMjAiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.yLCAsKBkommq0KxhH8MfpJrVRMig6yUdVKEGWutGQn0"]
    }

    let loginProvider = Provider<LoginService>()
    let mainProvider = Provider<MainService>()
}

extension ApiManager {

    func decoder<T: Codable>(model: T.Type, from data: Data) -> T? {
        do {
            guard let result = try? JSONDecoder().decode(model.self, from: data) else {
                return nil
            }
            return result
        } catch {
            return nil
        }
    }
}
