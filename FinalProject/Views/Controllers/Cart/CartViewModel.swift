//
//  CartViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation

final class CartViewModel {

    var carts: [Cart] = []

    func setData() {
        let p1 = Cart(id: 1, name: "Banh Gao", count: 1, price: 15)
        let p2 = Cart(id: 2, name: "Banh Kem", count: 1, price: 15)
        let p3 = Cart(id: 3, name: "Banh Bao", count: 2, price: 15)
        let p4 = Cart(id: 4, name: "Banh Xoai", count: 1, price: 15)
        let p5 = Cart(id: 5, name: "Banh Nam", count: 1, price: 15)
        let p6 = Cart(id: 6, name: "Banh Beo", count: 1, price: 15)
        carts.append(contentsOf: [p1, p2, p3, p4, p5, p6])
    }

    func updateCart(id: Int, count: Int, indexPath: IndexPath) {
        carts[indexPath.row].count = count
    }

    func viewModelForItem(at indexPath: IndexPath) -> CartCellViewModel {
        let cellViewModel = CartCellViewModel(cart: carts[indexPath.row])
        return cellViewModel
    }
}

final class Cart {

    var id: Int
    var name: String
    var count: Int
    var price: Int

    init(id: Int, name: String, count: Int, price: Int) {
        self.id = id
        self.name = name
        self.count = count
        self.price = price
    }
}
