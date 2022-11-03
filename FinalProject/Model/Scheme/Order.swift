//
//  Order.swift
//  FinalProject
//
//  Created by luong.tran on 03/11/2022.
//

import Foundation

struct OrderTransaction: Codable {

    var id: Int
    var orderId: Int
    var userId: Int
    var productId: Int
    var productName: String
    var productImage: String
    var quantity: Int
    var price: Int
    var date: String
    var status: Int

    enum CodingKeys: String, CodingKey {
        case id, quantity, price, status, date
        case orderId = "order_id"
        case userId = "user_id"
        case productId = "product_id"
        case productName = "product_name"
        case productImage = "image_product"
    }

    init(id: Int,
         orderId: Int,
         userId: Int,
         productId: Int,
         productName: String,
         productImage: String,
         quantity: Int,
         price: Int,
         date: String,
         status: Int) {
        self.id = id
        self.orderId = orderId
        self.userId = userId
        self.productId = productId
        self.productName = productName
        self.productImage = productImage
        self.quantity = quantity
        self.price = price
        self.date = date
        self.status = status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.price = try container.decode(Int.self, forKey: .price)
        self.status = try container.decode(Int.self, forKey: .status)
        self.date = try container.decode(String.self, forKey: .date)
        self.orderId = try container.decode(Int.self, forKey: .orderId)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.productId = try container.decode(Int.self, forKey: .productId)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.productImage = try container.decode(String.self, forKey: .productImage)
    }
}
