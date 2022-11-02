//
//  FavoriteTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

protocol FavoriteTableViewCellDelegate: AnyObject {
    func cell(_ cell: FavoriteTableViewCell, needPerform action: FavoriteTableViewCell.Action)
}

final class FavoriteTableViewCell: UITableViewCell {

    enum Action {
        case didTap
    }

    // MARK: - Outlets
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemSubLabel: UILabel!

    // MARK: - Properties
    var viewModel: FavoriteTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    weak var delegate: FavoriteTableViewCellDelegate?

    // MARK: - Override method
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Private method
    private func configUI() {
        itemImageView.layer.borderWidth = Define.borderWidth
        itemImageView.layer.cornerRadius = Define.cornerRadius
        itemImageView.layer.borderColor = Define.borderColor
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        itemImageView.downloadImage(from: (viewModel.product?.imageProduct).content)
        itemNameLabel.text = viewModel.product?.name
        itemSubLabel.text = viewModel.product?.category.shop.nameShop
    }

    // MARK: - Action
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, needPerform: .didTap)
    }
}

// MARK: - Define
extension FavoriteTableViewCell {
    private struct Define {
        static var borderWidth: CGFloat = 1.0
        static var cornerRadius: CGFloat = 10
        static var borderColor: CGColor = .init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    }
}
