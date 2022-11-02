//
//  PopularCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameProductLabel: UILabel!
    @IBOutlet private weak var categotyProductLabel: UILabel!
    @IBOutlet private weak var priceProductLabel: UILabel!

    var viewModel: PopularCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 20
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        productImageView.downloadImage(from: (viewModel.product?.imageProduct).content)
        nameProductLabel.text = viewModel.product?.name
        categotyProductLabel.text = viewModel.product?.category.nameCategory
        priceProductLabel.text = "\((viewModel.product?.price).unwrap(or: 0))"
    }
}
