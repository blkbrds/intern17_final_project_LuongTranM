//
//  TransactionCellViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 29/11/2022.
//

import Foundation

final class TransactionCellViewModel {

    var order: Cart?

    init(order: Cart? = nil) {
        self.order = order
    }
}
