//
//  ItemTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 22/11/2022.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var quantityItemLabel: UILabel!

    var viewModel: ItemCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        itemNameLabel.text = viewModel.item?.productName
        quantityItemLabel.text = "x\((viewModel.item?.quantity).unwrap(or: 0))"
    }
}
