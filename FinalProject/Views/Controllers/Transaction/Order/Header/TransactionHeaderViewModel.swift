//
//  TransactionHeaderViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 29/11/2022.
//

import Foundation

final class TransactionHeaderViewModel {
    var transaction: Transaction?

    init(transaction: Transaction? = nil) {
        self.transaction = transaction
    }
}
