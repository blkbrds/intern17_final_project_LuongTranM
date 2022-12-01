//
//  Order.swift
//  FinalProject
//
//  Created by luong.tran on 03/11/2022.
//

import Foundation

struct TransactionResponse: Codable {
    var success: Bool
    var data: [Transaction]?

    enum CodingKeys: String, CodingKey {
        case data, success
    }

    init(success: Bool, data: [Transaction]? = nil) {
        self.success = success
        self.data = data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([Transaction].self, forKey: .data)
        self.success = try container.decode(Bool.self, forKey: .success)
    }
}

struct Transaction: Codable {
    var transactionId: Int
    var userName: String
    var userPhone: String
    var address: String
    var amount: Int
    var payment: String?
    var paymentInfo: String?
    var security: String?
    var status: Int
    var createdAt: String
    var updatedAt: String
    var orders: [Cart]

    enum CodingKeys: String, CodingKey {
        case address, payment, amount, security, status
        case transactionId = "id"
        case userName = "user_name"
        case userPhone = "user_phone"
        case paymentInfo = "payment_info"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orders = "order"
    }

    init(transactionId: Int,
         userName: String,
         userPhone: String,
         address: String,
         amount: Int,
         payment: String? = nil,
         paymentInfo: String? = nil,
         security: String? = nil,
         status: Int,
         createdAt: String,
         updatedAt: String,
         orders: [Cart]) {
        self.transactionId = transactionId
        self.userName = userName
        self.userPhone = userPhone
        self.address = address
        self.amount = amount
        self.payment = payment
        self.paymentInfo = paymentInfo
        self.security = security
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.orders = orders
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try container.decode(String.self, forKey: .address)
        self.payment = try container.decodeIfPresent(String.self, forKey: .payment)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.security = try container.decodeIfPresent(String.self, forKey: .security)
        self.status = try container.decode(Int.self, forKey: .status)
        self.transactionId = try container.decode(Int.self, forKey: .transactionId)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userPhone = try container.decode(String.self, forKey: .userPhone)
        self.paymentInfo = try container.decodeIfPresent(String.self, forKey: .paymentInfo)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.orders = try container.decode([Cart].self, forKey: .orders)
    }
}
