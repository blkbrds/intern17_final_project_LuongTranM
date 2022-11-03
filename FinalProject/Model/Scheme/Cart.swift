//
//  Cart.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

struct Cart: Codable {

    var id: Int
    var userId: Int
    var productId: Int
    var productName: String
    var quantity: Int
    var price: Int
    var status: Int
    var image: String

    enum CodingKeys: String, CodingKey {
        case id, quantity, price, status
        case userId = "user_id"
        case productId = "product_id"
        case productName = "product_name"
        case image = "image_product"
    }

    init(id: Int,
         userId: Int,
         productId: Int,
         productName: String,
         quantity: Int,
         price: Int,
         status: Int,
         image: String) {
        self.id = id
        self.userId = userId
        self.productId = productId
        self.productName = productName
        self.quantity = quantity
        self.price = price
        self.status = status
        self.image = image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.price = try container.decode(Int.self, forKey: .price)
        self.status = try container.decode(Int.self, forKey: .status)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.productId = try container.decode(Int.self, forKey: .productId)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.image = try container.decode(String.self, forKey: .image)
    }
}
