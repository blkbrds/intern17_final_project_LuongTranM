//
//  PopularCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class PopularCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlet
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameProductLabel: UILabel!
    @IBOutlet private weak var categotyProductLabel: UILabel!
    @IBOutlet private weak var priceProductLabel: UILabel!

    // MARK: - Properties
    var viewModel: PopularCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 20
        productImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        productImageView.layer.cornerRadius = 20
    }

    // MARK: - Private methods
    private func updateUI() {
        guard let viewModel = viewModel,
              let product = viewModel.product else { return }
        productImageView.downloadImage(from: product.imageProduct)
        nameProductLabel.text = product.name
        categotyProductLabel.text = product.category?.nameCategory
        priceProductLabel.text = "$ \(product.price)"
    }
}
