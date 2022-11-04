//
//  ProfileViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class ProfileViewModel {

    var orderTrans: [OrderTransaction] = []

    #warning("Dummy Data")
    func getOrder() {
        let p1 = OrderTransaction(id: 1,
                                  orderId: 5,
                                  userId: 20,
                                  productId: 37,
                                  productName: "Santal Royal",
                                  productImage: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png",
                                  quantity: 2,
                                  price: 260,
                                  date: "2022-10-29",
                                  status: 1)
        let p2 = OrderTransaction(id: 1,
                                  orderId: 5,
                                  userId: 20,
                                  productId: 37,
                                  productName: "Santal Royal 2",
                                  productImage: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png",
                                  quantity: 2,
                                  price: 260,
                                  date: "2022-10-29",
                                  status: 1)
        let p3 = OrderTransaction(id: 1,
                                  orderId: 5,
                                  userId: 20,
                                  productId: 37,
                                  productName: "Santal Royal 3",
                                  productImage: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png",
                                  quantity: 2,
                                  price: 260,
                                  date: "2022-10-29",
                                  status: 1)

        orderTrans.append(contentsOf: [p1, p2, p3])
    }

    func numberOfRows(in section: Int) -> Int {
        return orderTrans.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> HistoryTableCellViewModel {
        guard let orderTran = orderTrans[safe: indexPath.row] else { return HistoryTableCellViewModel(orderTrans: nil) }
        return HistoryTableCellViewModel(orderTrans: orderTran)
    }
}
