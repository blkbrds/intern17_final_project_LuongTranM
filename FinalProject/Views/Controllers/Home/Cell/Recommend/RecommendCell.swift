//
//  RecommendCell.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

protocol RecommendCellDelegate: AnyObject {
    func cell(cell: RecommendCell, needPerform action: RecommendCell.Action)
}

final class RecommendCell: UITableViewCell {

    enum Action {
        case didTap(product: Product)
    }

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var viewAllLabel: UILabel!

    // MARK: - Properties
    weak var delegate: RecommendCellDelegate?
    var viewModel: RecommendCellViewModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Override method
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        addTapGesture()
    }

    // MARK: - Private method
    private func configCollectionView() {
        let cellNib = UINib(nibName: Define.cellName, bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewAllRecommend))
        viewAllLabel.addGestureRecognizer(tap)
    }

    // MARK: - Objc method
    @objc private func viewAllRecommend() {
        #warning("Handle Later")
    }
}

// MARK: - Define
extension RecommendCell {
    private struct Define {
        static var cellName: String = String(describing: RecommendCollectionViewCell.self)
    }
}

// MARK: - CollectionView Delegate, Datasource
extension RecommendCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel,
        let product = viewModel.products[safe: indexPath.row] else { return }
        delegate?.cell(cell: self, needPerform: .didTap(product: product))
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
