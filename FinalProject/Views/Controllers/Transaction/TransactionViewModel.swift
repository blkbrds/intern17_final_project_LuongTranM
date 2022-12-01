//
//  TransactionViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 28/11/2022.
//

import Foundation

final class TransactionViewModel {

    var transactions: [Transaction]?

    func test(startDay: String, endDay: String, completion: @escaping Completion<[Transaction]>) {
        ApiManager.shared.mainProvider.request(target: .transaction(startDay: startDay, endDay: endDay), model: TransactionResponse.self) { result in
            switch result {
            case .success(let response):
                guard let response = response as? TransactionResponse else {
                    completion(.failure(.noData))
                    return
                }
                self.transactions = response.data ?? []
                completion(.success(self.transactions ?? []))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func numberOfSections() -> Int {
        guard let transactions = transactions else { return 0 }
        return transactions.count
    }

    func viewModelForHeader(in section: Int) -> TransactionHeaderViewModel {
        guard let transactions = transactions else { return TransactionHeaderViewModel() }
        return TransactionHeaderViewModel(transaction: transactions[safe: section])
    }

    func numberOfRowsInSection(in section: Int) -> Int {
        guard let transactions = transactions else { return 0 }
        return (transactions[safe: section]?.orders.count).unwrap(or: 0)
    }

    func viewModelForItem(at indexPath: IndexPath) -> TransactionCellViewModel {
        guard let transactions = transactions else { return TransactionCellViewModel() }
        return TransactionCellViewModel(order: transactions[safe: indexPath.section]?.orders[safe: indexPath.row])
    }
}
