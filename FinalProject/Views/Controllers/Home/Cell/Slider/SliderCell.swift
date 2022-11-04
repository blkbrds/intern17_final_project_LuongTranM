//
//  SliderCell.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import UIKit

final class SliderCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - Properties
    var viewModel: SlideCellViewModel?
    private var timer: Timer?

    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        configUI()
    }

    // MARK: - Private methods
    private func configCollectionView() {
        let cellNib = UINib(nibName: Define.cellName, bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
        startTimer()
    }

    private func configUI() {
        pageControl.numberOfPages = 3
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Define.timerIntervar, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }

    // MARK: - Objc methods
    @objc private func moveToNextIndex() {
        guard let viewModel = viewModel else { return }
        if viewModel.currentIndex < 2 {
            viewModel.currentIndex += 1
        } else {
            viewModel.currentIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(row: viewModel.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = viewModel.currentIndex
    }
}

// MARK: - Define
extension SliderCell {
    private struct Define {
        static var cellName: String = String(describing: SlideCollectionViewCell.self)
        static var timerIntervar: Double = 2.5
    }
}

// MARK: - CollectionView Delegate, Datasource
extension SliderCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? SlideCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
}
