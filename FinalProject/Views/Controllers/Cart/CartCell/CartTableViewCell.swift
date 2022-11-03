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
        case increase(id: Int, count: Int)
        case decrease(id: Int, count: Int)
    }

    weak var delegate: CartTabeViewCellDelegate?

    @IBOutlet private weak var cartView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!

    var viewModel: CartCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private var count: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    private func configUI() {
        cartView.layer.cornerRadius = 10
        cartView.layer.borderWidth = 1

        let tapImage = UITapGestureRecognizer(target: self, action: #selector(selectCell))
        productImageView.isUserInteractionEnabled = true
        productImageView.addGestureRecognizer(tapImage)
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        let total: Int = viewModel.cart.price * viewModel.cart.quantity

        productImageView.downloadImage(from: viewModel.cart.image)
        nameLabel.text = viewModel.cart.productName
        priceLabel.text = "$ \(total)"
        countLabel.text = "\(viewModel.cart.quantity)"
    }

    @IBAction private func plusButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        count = viewModel.cart.quantity + 1
        delegate?.cell(cell: self, needPerform: .increase(id: viewModel.cart.id, count: count))
    }

    @IBAction private func minusButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        count = viewModel.cart.quantity - 1
        delegate?.cell(cell: self, needPerform: .decrease(id: viewModel.cart.id, count: count))
    }

    @objc private func selectCell() {
        #warning("Handle select item")
    }
}
