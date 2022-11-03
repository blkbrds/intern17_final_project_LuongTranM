//
//  CartViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation

final class CartViewModel {

    var carts: [Cart] = []
    var totalPrice: Int = 0

    func getData() {
        let p1 = Cart(id: 6,
                      userId: 20,
                      productId: 16,
                      productName: "Alphaskin Tie Headband",
                      quantity: 2,
                      price: 8,
                      status: 0,
                      image: "http://localhost:8000/storage/shop/product/1666968849_alphaskin_tie_headband_1.jpg")
        let p2 = Cart(id: 6,
                      userId: 20,
                      productId: 37,
                      productName: "Santal Royal",
                      quantity: 2,
                      price: 260,
                      status: 0,
                      image: "http://localhost:8000/storage/shop/product/1666968849_alphaskin_tie_headband_1.jpg")
        let p3 = Cart(id: 6,
                      userId: 20,
                      productId: 20,
                      productName: "Santal Royal Spapa Santal Royal Spapa",
                      quantity: 2,
                      price: 180,
                      status: 0,
                      image: "http://localhost:8000/storage/shop/product/1666968849_alphaskin_tie_headband_1.jpg")
        carts.append(contentsOf: [p1, p2, p3])
    }

    func totalPriceCarts() -> Int {
        var total: Int = 0
        for cart in carts {
            total += cart.quantity * cart.price
        }
        return total
    }

    func updateCart(count: Int, indexPath: IndexPath) {
        carts[indexPath.row].quantity = count
    }

    func numberOfRows(in section: Int) -> Int {
        return carts.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> CartCellViewModel {
        let cellViewModel = CartCellViewModel(cart: carts[indexPath.row])
        return cellViewModel
    }
}
