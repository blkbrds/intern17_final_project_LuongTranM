//
//  SlideCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class SlideCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlet
    @IBOutlet private weak var shopImageView: UIImageView!
    @IBOutlet private weak var nameShopLabel: UILabel!

    // MARK: - Properties
    var viewModel: SlideCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Private methods
    private func updateCell() {
        guard let viewModel = viewModel else { return }
        shopImageView.downloadImage(from: (viewModel.shop?.imageShop).content)
        nameShopLabel.text = (viewModel.shop?.nameShop).content.uppercased()
    }
}
