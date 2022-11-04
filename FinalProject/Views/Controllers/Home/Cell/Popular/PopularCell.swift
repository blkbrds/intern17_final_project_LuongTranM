//
//  PopularCell.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

protocol PopularCellDelegate: AnyObject {
    func cell(cell: PopularCell, needPerform action: PopularCell.Action)
}

final class PopularCell: UITableViewCell {

    enum Action {
        case didTap(product: Product?)
    }

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties
    weak var delegate: PopularCellDelegate?
    var viewModel: PopularCellViewModel?

    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    // MARK: - Private methods
    private func configCollectionView() {
        let cellNib = UINib(nibName: Define.cellName, bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Define
extension PopularCell {
    private struct Define {
        static var cellName: String = String(describing: PopularCollectionViewCell.self)
    }
}

// MARK: - TableView Delegate, Datasource
extension PopularCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        delegate?.cell(cell: self, needPerform: .didTap(product: viewModel.products[safe: indexPath.row]))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: 330)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
}
