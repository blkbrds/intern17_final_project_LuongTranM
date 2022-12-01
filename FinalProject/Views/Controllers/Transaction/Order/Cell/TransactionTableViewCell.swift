//
//  TransactionTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/11/2022.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    var viewModel: TransactionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.layer.cornerRadius = 10
        itemImageView.layer.masksToBounds = true
    }

    private func updateCell() {
        guard let viewModel = viewModel, let order = viewModel.order else { return }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        itemImageView.downloadImage(from: order.productImage)
        itemNameLabel.text = order.productName
        quantityLabel.text = "x\(order.quantity)"
        if let formattedTipAmount = formatter.string(from: order.price as NSNumber) {
            priceLabel.text = "\(formattedTipAmount)"
        }
    }
}
