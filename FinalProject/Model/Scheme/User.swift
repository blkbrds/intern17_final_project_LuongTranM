//
//  User.swift
//  FinalProject
//
//  Created by luong.tran on 14/11/2022.
//

import Foundation

struct UserResponse: Codable {
    var data: User

    enum CodingKeys: String, CodingKey {
        case data
    }

    init(data: User) {
        self.data = data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(User.self, forKey: .data)
    }
}

struct User: Codable {
    var id: Int
    var userName: String
    var email: String
    var gender: Int
    var phoneNumber: String
    var address: String

    enum CodingKeys: String, CodingKey {
        case id, email, gender, address
        case userName = "user_name"
        case phoneNumber = "phone_number"
    }

    init(id: Int,
         userName: String,
         email: String,
         gender: Int,
         phoneNumber: String,
         address: String) {
        self.id = id
        self.userName = userName
        self.email = email
        self.gender = gender
        self.phoneNumber = phoneNumber
        self.address = address
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.gender = try container.decode(Int.self, forKey: .gender)
        self.address = try container.decode(String.self, forKey: .address)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
    }
}
