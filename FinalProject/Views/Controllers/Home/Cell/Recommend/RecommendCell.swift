//
//  RecommendCell.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

final class RecommendCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var viewAllLabel: UILabel!

    var viewModel: RecommendCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        configUI()
    }

    private func configCollectionView() {
        let cellNib = UINib(nibName: Define.cellName, bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewAllRecommend))
        self.addGestureRecognizer(tap)
    }

    @objc private func viewAllRecommend() {
        #warning("Handle Later")
    }
}

extension RecommendCell {
    private struct Define {
        static var cellName: String = String(describing: RecommendCollectionViewCell.self)
    }
}

extension RecommendCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel?.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }
}
