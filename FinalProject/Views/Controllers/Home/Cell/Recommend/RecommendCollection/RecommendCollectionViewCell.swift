//
//  RecommendCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameProductLabel: UILabel!
    @IBOutlet private weak var priceProductLabel: UILabel!
    @IBOutlet private weak var shopLabel: UILabel!

    var viewModel: RecommendCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        customViewShadow()
    }

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
        guard let viewModel = viewModel else { return }
        productImageView.downloadImage(from: (viewModel.product?.imageProduct).content)
        nameProductLabel.text = (viewModel.product?.name).content
        priceProductLabel.text = "\((viewModel.product?.price).unwrap(or: 0))"
        shopLabel.text = (viewModel.product?.category.shop.nameShop).content
    }
}
