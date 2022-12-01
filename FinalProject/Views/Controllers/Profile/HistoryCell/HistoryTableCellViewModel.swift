//
//  HistoryTableCellViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class HistoryTableCellViewModel {

    var orderTrans: Cart?

    init(orderTrans: Cart?) {
        self.orderTrans = orderTrans
    }
}
