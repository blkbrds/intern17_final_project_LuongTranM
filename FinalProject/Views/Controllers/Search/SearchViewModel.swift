//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class SearchViewModel {

    var products: [Product] = []
    var searchProducts: [Product] = []
    var searching: Bool = false
    var scopeButtonPress: Bool = false

    #warning("Dummy Data")
    func getProduct() {
        let p1 = Product(id: 37,
                         name: "Medium crescent-shaped shoulder bag",
                         imageProduct: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png",
                         discount: 0,
                         content: "Beyond physical health, this product can help to improve your mood, enhance your appearance and boost your self-esteem. It can also help to exhibit personal style and it is an important element of social expression.",
                         price: 260,
                         category: Category(id: 16,
                                            nameCategory: "Perfume",
                                            shop: Shop(id: 9,
                                                       nameShop: "Guerlain",
                                                       address: "HCM",
                                                       phoneNumber: "0123456789",
                                                       emailShop: "guerlain@gmail.com",
                                                       imageShop: "shop/1666972408_guerlain_logo.png",
                                                       description: "Guerlain Shop")),
                         images: [ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_2.jpg"),
                                  ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_3.jpg"),
                                  ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_4.jpg")])
        let p2 = Product(id: 38,
                         name: "Santal Royal 1",
                         imageProduct: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png",
                         discount: 0,
                         content: "Beyond physical health, this product can help to improve your mood, enhance your appearance and boost your self-esteem. It can also help to exhibit personal style and it is an important element of social expression.",
                         price: 260,
                         category: Category(id: 16,
                                            nameCategory: "Perfume",
                                            shop: Shop(id: 9,
                                                       nameShop: "Guerlain",
                                                       address: "HCM",
                                                       phoneNumber: "0123456789",
                                                       emailShop: "guerlain@gmail.com",
                                                       imageShop: "shop/1666972408_guerlain_logo.png",
                                                       description: "Guerlain Shop")),
                         images: [ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_2.jpg"),
                                  ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_3.jpg"),
                                  ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_4.jpg")])
        let p3 = Product(id: 39,
                         name: "Santal Royal 2",
                         imageProduct: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png",
                         discount: 0,
                         content: "Beyond physical health, this product can help to improve your mood, enhance your appearance and boost your self-esteem. It can also help to exhibit personal style and it is an important element of social expression.",
                         price: 260,
                         category: Category(id: 16,
                                            nameCategory: "Perfume",
                                            shop: Shop(id: 9,
                                                       nameShop: "Guerlain",
                                                       address: "HCM",
                                                       phoneNumber: "0123456789",
                                                       emailShop: "guerlain@gmail.com",
                                                       imageShop: "shop/1666972408_guerlain_logo.png",
                                                       description: "Guerlain Shop")),
                         images: [ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_2.jpg"),
                                  ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_3.jpg"),
                                  ImageProduct(image: "http://localhost:8000/storage/shop/product/1666973112_santal_royal_4.jpg")])
        products.append(contentsOf: [p1, p2, p3])
    }

    func numberOfItems(in section: Int) -> Int {
        if searching || scopeButtonPress {
            return searchProducts.count
        } else {
            return products.count
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> SearchCollectionCellViewModel {
        if searching || scopeButtonPress {
            guard let product = searchProducts[safe: indexPath.row] else { return SearchCollectionCellViewModel(product: nil) }
            return SearchCollectionCellViewModel(product: product)
        } else {
            guard let product = products[safe: indexPath.row] else { return SearchCollectionCellViewModel(product: nil) }
            return SearchCollectionCellViewModel(product: product)
        }
    }

    func viewDetailForItem(at indexPath: IndexPath) -> DetailViewModel {
        if searching || scopeButtonPress {
            guard let product = searchProducts[safe: indexPath.row] else { return DetailViewModel(product: nil) }
            return DetailViewModel(product: product)
        } else {
            guard let product = products[safe: indexPath.row] else { return DetailViewModel(product: nil) }
            return DetailViewModel(product: product)
        }
    }
}
