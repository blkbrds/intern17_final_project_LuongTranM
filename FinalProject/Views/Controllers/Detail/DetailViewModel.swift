//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import Foundation

final class DetailViewModel {

    var product: Product?

    init(product: Product?) {
        self.product = product
    }

    var currentIndex: Int = 0

    func requestAddToCart(id: Int, quantity: Int, completion: @escaping Completion<MessageResponse>) {
        ApiManager.shared.mainProvider.request(target: .addCart(id: id, quantity: quantity), model: MessageResponse.self) { result in
            switch result {
            case .success(let value):
                guard let value = value as? MessageResponse else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> CarouselCollectionCellViewModel {
        return CarouselCollectionCellViewModel(image: (product?.images[safe: indexPath.row]?.image).content)
    }
}
