//
//  CarouselCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var productImageView: UIImageView!

    // MARK: - Properties
    var viewModel: CarouselCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Private methods
    private func updateCell() {
        guard let viewModel = viewModel else { return }
        productImageView.downloadImage(from: viewModel.image)
    }
}
