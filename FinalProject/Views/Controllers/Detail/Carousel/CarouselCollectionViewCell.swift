//
//  CarouselCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!

    var viewModel: CarouselCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        productImageView.downloadImage(from: viewModel.image)
    }
}
