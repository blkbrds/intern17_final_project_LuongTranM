//
//  RecommendCollectionViewCell.swift
//  FinalProject
//
//  Created by luong.tran on 29/10/2022.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        customViewShadow()
    }

    private func customViewShadow() {
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 20

        cellView.layer.masksToBounds = false
        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowRadius = 5
    }

}
