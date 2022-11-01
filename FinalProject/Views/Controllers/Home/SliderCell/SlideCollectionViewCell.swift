//
//  SlideCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var shopImageView: UIImageView!
    @IBOutlet private weak var nameShopLabel: UILabel!

    var viewModel: SlideCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        #warning("Handle link image: http://localhost:8000/storage/shop/product/1666973112_santal_royal_1.png")
        shopImageView.image = UIImage(named: viewModel.imageName)
        nameShopLabel.text = viewModel.shopName.uppercased()
    }

}
