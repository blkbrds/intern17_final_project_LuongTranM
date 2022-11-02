//
//  HomeViewController.swift
//  FinalProject
//
//  Created by luong.tran on 27/10/2022.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var slideCollectionView: UICollectionView!
    @IBOutlet private weak var recommendCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!

    var viewModel: HomeViewModel?
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func configNavigation() {
        navigationItem.title = Define.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    private func configCollectionView() {
        let slideNib = UINib(nibName: Define.slideCollectionCell, bundle: Bundle.main)
        slideCollectionView.register(slideNib, forCellWithReuseIdentifier: Define.slideCollectionCell)
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
        startTimer()

        let recommendNib = UINib(nibName: Define.recommendCollectionCell, bundle: Bundle.main)
        recommendCollectionView.register(recommendNib, forCellWithReuseIdentifier: Define.recommendCollectionCell)
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self

        let popularNib = UINib(nibName: Define.popularCollectionCell, bundle: Bundle.main)
        popularCollectionView.register(popularNib, forCellWithReuseIdentifier: Define.popularCollectionCell)
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Define.timerIntervar, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }

    @objc private func moveToNextIndex() {
        guard let viewModel = viewModel else { return }
        if viewModel.currentCellIndex < viewModel.images.count - 1 {
            viewModel.currentCellIndex += 1
        } else {
            viewModel.currentCellIndex = 0
        }
        slideCollectionView.scrollToItem(at: IndexPath(row: viewModel.currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = viewModel.currentCellIndex
    }

}

extension HomeViewController {
    private struct Define {
        static var title: String = "Discover"
        static var insetDefault: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static var insetPopular: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static var insetRecommend: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        static var lineSpacingDefault: CGFloat = 0
        static var lineSpacingPopular: CGFloat = 10
        static var lineSpacingRecommend: CGFloat = 15
        static var slideCollectionCell: String = String(describing: SlideCollectionViewCell.self)
        static var recommendCollectionCell: String = String(describing: RecommendCollectionViewCell.self)
        static var popularCollectionCell: String = String(describing: PopularCollectionViewCell.self)
        static var timerIntervar: Double = 2.5
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case slideCollectionView:
            #warning("Handle number default")
            guard let viewModel = viewModel else { return 0 }
            pageControl.numberOfPages = viewModel.images.count
            return viewModel.images.count
        default:
            return 6
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case slideCollectionView:
            guard let viewModel = viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.slideCollectionCell, for: indexPath) as? SlideCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.viewModel = viewModel.viewModelForItem(at: indexPath)
            return cell
        case recommendCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.recommendCollectionCell, for: indexPath) as? RecommendCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case popularCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.popularCollectionCell, for: indexPath) as? PopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case slideCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case recommendCollectionView:
            return CGSize(width: collectionView.frame.width, height: 180)
        case popularCollectionView:
            return CGSize(width: view.frame.width / 2 - 15, height: 350)
        default:
            return CGSize(width: 10, height: 10)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case recommendCollectionView:
            return Define.insetRecommend
        case popularCollectionView:
            return Define.insetPopular
        default:
            return Define.insetDefault
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case recommendCollectionView:
            return Define.lineSpacingRecommend
        case popularCollectionView:
            return Define.lineSpacingPopular
        default:
            return Define.lineSpacingDefault
        }
    }
}
