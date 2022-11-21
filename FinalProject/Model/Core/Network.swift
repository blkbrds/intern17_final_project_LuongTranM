//
//  Network.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol TargetType {

    var baseURL: String { get }

    var path: String { get }

    var method: Method { get }

    var header: ReaquestHeaders? { get }

    var params: RequestParameters? { get }

    var body: RequestBodys? { get }
}

extension TargetType {

    var baseURL: String {
        return "http://127.0.0.1:8000/api/v1/user/"
    }

    var queryItems: [URLQueryItem]? {
        guard let parameters = params,
              !parameters.isEmpty else {
            return nil
        }

        return parameters.map { name, value in
            return URLQueryItem(name: name, value: value)
        }
    }

    public func urlRequest() -> URLRequest? {
        guard let url = url(with: baseURL) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header

        if let body = body,
           let httpBody = try? JSONSerialization.data(withJSONObject: body as Dictionary, options: []) {
            request.httpBody = httpBody
        }

        return request
    }

    private func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }

        urlComponents.path += path
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
}

protocol ProviderType {

    associatedtype Target: TargetType

    func request<T: Codable>(target: Target,
                             model: T.Type,
                             completion: @escaping APICompletion)
}

class Provider<Target: TargetType>: ProviderType {

    func request<T: Codable>(target: Target, model: T.Type, completion: @escaping APICompletion) {
        // Check Interneet is available
        if !Reachability.isInternetAvailable() {
            completion(.failure(.noInternet))
            return
        }

        // Create request
        guard let request = target.urlRequest() else {
            completion(.failure(.badRequest))
            return
        }

        // Config
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true

        // Session
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { data, response, _ in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                switch response.statusCode {
                case 200...299:
                    if let data = data {
                        let result = ApiManager.shared.decoder(model: T.self, from: data)
                        completion(.success(result))
                    } else {
                        completion(.failure(.noData))
                    }
                case 400...499:
                    completion(.failure(.badRequest))
                default:
                    completion(.failure(.unknown))
                }
            }
        }

        task.resume()
    }
}
