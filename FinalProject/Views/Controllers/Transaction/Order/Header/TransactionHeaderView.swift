//
//  TransactionHeaderView.swift
//  FinalProject
//
//  Created by luong.tran on 29/11/2022.
//

import UIKit

final class TransactionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var transactionIdLabel: UILabel!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var userOrderLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var orderDateLabel: UILabel!

    var viewModel: TransactionHeaderViewModel? {
        didSet {
            updateHeader()
        }
    }

    private func updateHeader() {
        guard let viewModel = viewModel,
              let transaction = viewModel.transaction else { return }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        transactionIdLabel.text = "Transaction ID: \(transaction.transactionId)"
        if let formattedTipAmount = formatter.string(from: transaction.amount as NSNumber) {
            totalPriceLabel.text = "Total: \(formattedTipAmount)"
        }
        userOrderLabel.text = transaction.userName
        addressLabel.text = transaction.address
        phoneNumberLabel.text = transaction.userPhone
        let format = Date().convertDateFormat(inputDate: transaction.updatedAt)
        orderDateLabel.text = String(describing: format)
    }
}
