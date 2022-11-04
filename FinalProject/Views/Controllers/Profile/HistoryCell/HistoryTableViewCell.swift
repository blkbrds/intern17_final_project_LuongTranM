//
//  HistoryTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productQuantityLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productOrderedLabel: UILabel!

    // MARK: - Properties
    var viewModel: HistoryTableCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Private methods
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        let total = (viewModel.orderTrans?.price).unwrap(or: 0) * (viewModel.orderTrans?.quantity).unwrap(or: 0)

        productImageView.downloadImage(from: (viewModel.orderTrans?.productImage).content)
        productNameLabel.text  = viewModel.orderTrans?.productName
        productQuantityLabel.text = "x\((viewModel.orderTrans?.quantity).unwrap(or: 0))"
        productPriceLabel.text = "$\(total)"
        productOrderedLabel.text = viewModel.orderTrans?.date
    }
}
