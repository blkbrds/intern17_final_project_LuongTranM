//
//  RecommendCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameProductLabel: UILabel!
    @IBOutlet private weak var priceProductLabel: UILabel!
    @IBOutlet private weak var shopLabel: UILabel!

    // MARK: - Properties
    var viewModel: RecommendCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        customViewShadow()
        productImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        productImageView.layer.cornerRadius = 20
    }

    // MARK: - Private method
    private func customViewShadow() {
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 20

        cellView.layer.masksToBounds = false
        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowRadius = 5
    }

    private func updateUI() {
        guard let viewModel = viewModel,
              let product = viewModel.product else { return }
        productImageView.downloadImage(from: product.imageProduct)
        nameProductLabel.text = product.name
        priceProductLabel.text = "$ \(product.price)"
        shopLabel.text = (product.category?.shop?.nameShop).content
    }
}
