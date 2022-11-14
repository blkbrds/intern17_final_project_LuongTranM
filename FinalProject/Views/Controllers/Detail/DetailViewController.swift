//
//  DetailViewController.swift
//  FinalProject
//
//  Created by luong.tran on 01/11/2022.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var contentProductView: UIView!
    @IBOutlet private weak var addProductView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var nameProductLabel: UILabel!
    @IBOutlet private weak var priceProductLabel: UILabel!
    @IBOutlet private weak var categoryProductLabel: UILabel!
    @IBOutlet private weak var shopProductLabel: UILabel!
    @IBOutlet private weak var descriptionProductLabel: UILabel!
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var totalProductLabel: UILabel!

    // MARK: - Properties
    var viewModel: DetailViewModel?
    private var timer: Timer?
    private var favoriteButton: UIBarButtonItem?
    private var quantity: Int = 1 {
        didSet {
            updateQuantity()
        }
    }

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavigation()
        configCollectionView()
        updateQuantity()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Private methods
    private func configUI() {
        configSubView()
        addToCartButton.layer.cornerRadius = Define.cornerRadius

        guard let viewModel = viewModel,
              let product = viewModel.product else { return }
        nameProductLabel.text = product.name
        priceProductLabel.text = "$ \(product.price)"
        categoryProductLabel.text = product.category?.nameCategory
        shopProductLabel.text = product.category?.shop?.nameShop
        descriptionProductLabel.text = product.content
    }

    private func configNavigation() {
        guard let viewModel = viewModel,
              let product = viewModel.product else { return }

        // Create bar button
        let backButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "chevron"), style: .plain, target: self, action: #selector(returnButtonTouchUpInside))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton

        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonTouchUpInside))
        // Check and update color favorite button
        updateColorFavorite(isFavorite: viewModel.isFavorite(product: product))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    private func updateColorFavorite(isFavorite: Bool) {
        favoriteButton?.tintColor = isFavorite ? .red : .black
    }

    private func configCollectionView() {
        let slideNib = UINib(nibName: Define.cellName, bundle: Bundle.main)
        collectionView.register(slideNib, forCellWithReuseIdentifier: Define.cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
        startTimer()
    }

    private func configSubView() {
        addProductView.layer.cornerRadius = Define.cornerRadius
        addProductView.layer.maskedCorners = Define.maskedCorners
        addProductView.layer.shadowColor = Define.shadowColor
        addProductView.layer.shadowOpacity = Define.shadowOpacity
        addProductView.layer.shadowOffset = Define.shadowOffset
        addProductView.layer.shadowRadius = Define.shadowRadius

        contentProductView.clipsToBounds = true
        contentProductView.layer.cornerRadius = Define.cornerRadius
        contentProductView.layer.maskedCorners = Define.maskedCorners
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Define.timerIntervar, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }

    private func updateQuantity() {
        guard let viewModel = viewModel else { return }
        let total = quantity * (viewModel.product?.price).unwrap(or: 0)
        quantityLabel.text = "\(quantity)"
        totalProductLabel.text = "Total: $\(total)"
    }

    // MARK: - Action methods
    @IBAction private func decreaseButtonTouchUpInside(_ sender: Any) {
        quantity = quantity == 1 ? 1 : quantity - 1
    }

    @IBAction private func increaseButtonTouchUpInside(_ sender: Any) {
        quantity += 1
    }

    @IBAction private func addCartButtonTouchUpInside(_ sender: Any) {
        #warning("Handle later")
    }

    // MARK: - Objc methods
    @objc private func favoriteButtonTouchUpInside() {
        guard let viewModel = viewModel, let product = viewModel.product else { return }
        let isFavorite = viewModel.isFavorite(product: product)
        if !isFavorite {
            viewModel.addFavoriteProduct { [weak self] done in
                guard let this = self else { return }
                if !done {
                    this.alert(msg: "Can't Add", completion: nil)
                }
            }
        } else {
            viewModel.deleteFavoriteProduct { [weak self] done in
                guard let this = self else { return }
                if !done {
                    this.alert(msg: "Can't Delete", completion: nil)
                }
            }
        }
        updateColorFavorite(isFavorite: !isFavorite)
    }

    @objc private func returnButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func moveToNextIndex() {
        guard let viewModel = viewModel else { return }
        if viewModel.currentIndex < (viewModel.product?.images.count).unwrap(or: 0) - 1 {
            viewModel.currentIndex += 1
        } else {
            viewModel.currentIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(row: viewModel.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension DetailViewController {
    private struct Define {
        static var cellName: String = String(describing: CarouselCollectionViewCell.self)
        static var insetDefault: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static var lineSpacingDefault: CGFloat = 0
        static var cornerRadius: CGFloat = 25
        static var shadowOffset: CGSize = CGSize(width: 3, height: 0)
        static var shadowOpacity: Float = 1
        static var shadowRadius: CGFloat = 3
        static var shadowColor: CGColor = UIColor.lightGray.cgColor
        static var maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        static var timerIntervar: Double = 2.5
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return (viewModel.product?.images.count).unwrap(or: 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellName, for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Define.insetDefault
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Define.lineSpacingDefault
    }
}
