//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

final class LoginViewModel {

    func requestAPI(completion: @escaping Completion<WeatherResponse>) {
        ApiManager.shared.loginProvider.request(target: .testAPI, model: WeatherResponse.self) { result in
            switch result {
            case .success(let value):
                guard let value = value as? WeatherResponse else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
