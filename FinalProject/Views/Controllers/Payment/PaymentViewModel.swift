//
//  PaymentViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 21/11/2022.
//

import Foundation

final class PaymentViewModel {

    var carts: [Cart]
    var totalMoney: Int

    init(carts: [Cart], totalMoney: Int) {
        self.carts = carts
        self.totalMoney = totalMoney
    }

    func getApiUser(completion: @escaping Completion<User>) {
        ApiManager.shared.mainProvider.request(target: .user, model: UserResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? UserResponse else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(response.data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func requestCreateTransaction(body: Payment, completion: @escaping Completion<MessageResponse>) {
        ApiManager.shared.mainProvider.request(target: .createTransaction(body: body), model: MessageResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? MessageResponse else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(response))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func numberOfRows(in section: Int) -> Int {
        return carts.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> ItemCellViewModel {
        guard let item = carts[safe: indexPath.row] else { return ItemCellViewModel(item: nil) }
        return ItemCellViewModel(item: item)
    }
}
