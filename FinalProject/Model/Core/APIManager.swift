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
            "Authorization": "Bearer \(Session.shared.token)"]
    }

    let loginProvider = Provider<LoginService>()
    let mainProvider = Provider<MainService>()
}

extension ApiManager {

    func decoder<T: Codable>(model: T.Type, from data: Data) -> T? {
        do {
            let result = try JSONDecoder().decode(model.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}
