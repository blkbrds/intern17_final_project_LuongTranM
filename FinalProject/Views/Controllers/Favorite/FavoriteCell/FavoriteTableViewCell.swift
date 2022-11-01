//
//  FavoriteTableViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

protocol FavoriteTableViewCellDelegate: AnyObject {
    func cell(cell: FavoriteTableViewCell, needPerform action: FavoriteTableViewCell.Action)
}

final class FavoriteTableViewCell: UITableViewCell {

    enum Action {
        case didTap
    }

    weak var delegate: FavoriteTableViewCellDelegate?

    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemSubLabel: UILabel!

    var viewModel: FavoriteTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    private func configUI() {
        itemImageView.layer.borderWidth = 1.0
        itemImageView.layer.cornerRadius = 10
        itemImageView.layer.borderColor = .init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
        itemNameLabel.text = viewModel.name
    }

    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.cell(cell: self, needPerform: .didTap)
    }

}
