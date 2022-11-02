//
//  SearchCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productImageview: UIImageView!

    var viewModel: SearchCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth  = Define.borderWidth
        contentView.layer.cornerRadius = Define.cornerRadius
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        productNameLabel.text = (viewModel.product?.name).content
        productImageview.downloadImage(from: (viewModel.product?.imageProduct).content)
    }
}

extension SearchCollectionViewCell {
    private struct Define {
        static var borderWidth: CGFloat = 1.0
        static var cornerRadius: CGFloat = 20
    }
}
