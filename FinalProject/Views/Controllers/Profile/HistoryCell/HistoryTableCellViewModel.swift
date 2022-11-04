//
//  HistoryTableCellViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class HistoryTableCellViewModel {

    var orderTrans: OrderTransaction?

    init(orderTrans: OrderTransaction?) {
        self.orderTrans = orderTrans
    }
}
