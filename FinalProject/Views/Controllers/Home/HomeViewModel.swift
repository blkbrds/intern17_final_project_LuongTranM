//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import Foundation

final class HomeViewModel {

    enum CellType {
        case slide
        case recommend
        case popular
    }

    var cellType: CellType = .slide
    var shops: [Shop] = []
    var currentCellIndex: Int = 0
    var products: [Product]?

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
        products = []
        products?.append(contentsOf: [p1, p2, p3])
    }

    func getShop() {
        let p1 = Shop(id: 1,
                      nameShop: "Guarlain",
                      address: "abc",
                      phoneNumber: "012345566",
                      emailShop: "123",
                      imageShop: "http://localhost:8000/storage/shop/1666972408_guerlain_logo.png",
                      description: "abc")
        let p2 = Shop(id: 2,
                      nameShop: "Adidas",
                      address: "abc",
                      phoneNumber: "012345566",
                      emailShop: "123",
                      imageShop: "http://localhost:8000/storage/shop/1666968564_adidas_logo.png",
                      description: "abc")
        let p3 = Shop(id: 3,
                      nameShop: "Gucci",
                      address: "abc",
                      phoneNumber: "012345566",
                      emailShop: "123",
                      imageShop: "http://localhost:8000/storage/shop/1666970628_gucci_logo.jpeg",
                      description: "abc")

        shops.append(contentsOf: [p1, p2, p3])
    }

    func viewModelForItem(at indexPath: IndexPath) -> Any? {
        switch cellType {
        case .slide:
            return SlideCellViewModel(shops: shops)
        case .recommend:
            return RecommendCellViewModel(products: products)
        case .popular:
            guard let products = products else { return PopularCellViewModel(products: []) }
            return PopularCellViewModel(products: products)
        }
    }

}
