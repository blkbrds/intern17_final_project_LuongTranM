//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

final class LoginViewModel {

    func requestAPI(completion: @escaping Completion<WeatherResponse>) {
        ApiManager.shared.loginProvider.request(target: .testAPI) { result in
            switch result {
            case .success(let data):
                if let value = ApiManager.shared.decoder(model: WeatherResponse.self, from: data) {
                    completion(.success(value))
                } else {
                    completion(.failure(.parseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
