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
        cartView.layer.cornerRadius = 20
        cartView.layer.shadowColor = UIColor.lightGray.cgColor
        cartView.layer.shadowOpacity = 0.5
        cartView.layer.shadowOffset = CGSize.zero
        cartView.layer.shadowRadius = 3
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        let total: Int = viewModel.cart.price * viewModel.cart.count
        nameLabel.text = viewModel.cart.name
        priceLabel.text = "\(total)$"
        countLabel.text = "\(viewModel.cart.count)"
    }

    @IBAction private func plusButtonTouchUpInside(_ sender: Any) {
        guard let delegate = delegate,
              let viewModel = viewModel
        else { return }
        count = viewModel.cart.count + 1
        delegate.cell(cell: self, needPerform: .increase(id: viewModel.cart.id, count: count))
    }

    @IBAction private func minusButtonTouchUpInside(_ sender: Any) {
        guard let delegate = delegate,
              let viewModel = viewModel
        else { return }
        count = viewModel.cart.count - 1
        delegate.cell(cell: self, needPerform: .decrease(id: viewModel.cart.id, count: count))
    }

}
