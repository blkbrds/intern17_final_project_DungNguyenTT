//
//  CategoriesCell.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class CategoriesCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Property
    var viewModel: CategoriesCellViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARL: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }

    // MARK: - Private function
    private func configCell() {
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0.0, right: 20)
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategorieCell else {
            return UICollectionViewCell()
        }
        guard let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 20
        return CGSize(width: screenWidth / 5, height: (screenWidth / 5) * 7 / 5)
    }
}
