//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

final class LoginViewModel {

    func requestLoginAPI(email: String, password: String, completion: @escaping Completion<LoginRespone>) {
        ApiManager.shared.loginProvider.request(target: .login(email: email, password: password), model: LoginRespone.self) { result in
            switch result {
            case .success(let value):
                guard let value = value as? LoginRespone else {
                    completion(.failure(.noData))
                    return
                }
                let authToken = value.data.accessToken
                userDefaults.set(authToken, forKey: "authToken")
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
