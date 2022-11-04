//
//  SearchCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productImageview: UIImageView!

    // MARK: - Properties
    var viewModel: SearchCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth  = Define.borderWidth
        contentView.layer.cornerRadius = Define.cornerRadius
    }

    // MARK: - Override methods
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        productNameLabel.text = (viewModel.product?.name).content
        productImageview.downloadImage(from: (viewModel.product?.imageProduct).content)
    }
}

// MARK: - Define
extension SearchCollectionViewCell {
    private struct Define {
        static var borderWidth: CGFloat = 1.0
        static var cornerRadius: CGFloat = 20
    }
}
