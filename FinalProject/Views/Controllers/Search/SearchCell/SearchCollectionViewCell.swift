//
//  SearchCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageview: UIImageView!

    var viewModel: SearchCollectionCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth  = 1
        contentView.layer.cornerRadius = 20
    }

}
