//
//  HistoryTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productQuantityLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productOrderedLabel: UILabel!

    var viewModel: HistoryTableCellViewModel?

}
