//
//  Payment.swift
//  FinalProject
//
//  Created by luong.tran on 22/11/2022.
//

import Foundation

struct Payment {
    var orderIds: [Int]
    var userName: String
    var phoneNumber: String
    var address: String
    var amount: Int

    init(orderIds: [Int], userName: String, phoneNumber: String, address: String, amount: Int) {
        self.orderIds = orderIds
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.address = address
        self.amount = amount
    }
}
