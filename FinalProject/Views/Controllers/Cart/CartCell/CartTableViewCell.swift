//
//  CartTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

protocol CartTabeViewCellDelegate: AnyObject {
    func cell(cell: CartTableViewCell, needPerform action: CartTableViewCell.Action)
}

final class CartTableViewCell: UITableViewCell {

    enum Action {
        case increase
        case decrease
    }

    // MARK: - Outlets
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!

    // MARK: - Properties
    weak var delegate: CartTabeViewCellDelegate?
    var viewModel: CartCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Private methods
    private func configUI() {
        productImageView.layer.cornerRadius = Define.cornerRadius
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }

        productImageView.downloadImage(from: viewModel.cart.productImage)
        nameLabel.text = viewModel.cart.productName
        priceLabel.text = "$ \(viewModel.cart.price)"
        countLabel.text = "\(viewModel.cart.quantity)"
    }

    // MARK: - Private method
    @IBAction private func plusButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(cell: self, needPerform: .increase)
    }

    @IBAction private func minusButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(cell: self, needPerform: .decrease)
    }
}

extension CartTableViewCell {
    private struct Define {
        static var cornerRadius: CGFloat = 10
    }
}
