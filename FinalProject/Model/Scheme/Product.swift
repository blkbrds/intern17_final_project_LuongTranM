//
//  Product.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

struct Product: Codable {

    var id: Int
    var name: String
    var imageProduct: String
    var discount: Int
    var content: String
    var price: Int
    var category: Category
    var images: [ImageProduct]

    enum CodingKeys: String, CodingKey {
        case id, name, discount, content, price, category, images
        case imageProduct = "image_product"
    }

    init(id: Int,
         name: String,
         imageProduct: String,
         discount: Int,
         content: String,
         price: Int,
         category: Category,
         images: [ImageProduct]) {
        self.id = id
        self.name = name
        self.imageProduct = imageProduct
        self.discount = discount
        self.content = content
        self.price = price
        self.category = category
        self.images = images
    }

}

struct Category: Codable {

    var id: Int
    var nameCategory: String
    var shop: Shop

    enum CodingKeys: String, CodingKey {
        case id, shop
        case nameCategory = "name_category"
    }

    init(id: Int, nameCategory: String, shop: Shop) {
        self.id = id
        self.nameCategory = nameCategory
        self.shop = shop
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.shop = try container.decode(Shop.self, forKey: .shop)
        self.nameCategory = try container.decode(String.self, forKey: .nameCategory)
    }
}

struct Shop: Codable {

    var id: Int
    var nameShop: String
    var address: String
    var phoneNumber: String
    var emailShop: String
    var imageShop: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case id, address, description
        case nameShop = "name_shop"
        case phoneNumber = "phone_number"
        case emailShop = "email_shop"
        case imageShop = "image_shop"
    }

    init(
        id: Int,
        nameShop: String,
        address: String,
        phoneNumber: String,
        emailShop: String,
        imageShop: String,
        description: String) {
        self.id = id
        self.nameShop = nameShop
        self.address = address
        self.phoneNumber = phoneNumber
        self.emailShop = emailShop
        self.imageShop = imageShop
        self.description = description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.address = try container.decode(String.self, forKey: .address)
        self.description = try container.decode(String.self, forKey: .description)
        self.nameShop = try container.decode(String.self, forKey: .nameShop)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.emailShop = try container.decode(String.self, forKey: .emailShop)
        self.imageShop = try container.decode(String.self, forKey: .imageShop)
    }

}

struct ImageProduct: Codable {

    var image: String

    enum CodingKeys: String, CodingKey {
        case image
    }

    init(image: String) {
        self.image = image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        image = try values.decode(String.self, forKey: .image)
    }
}
