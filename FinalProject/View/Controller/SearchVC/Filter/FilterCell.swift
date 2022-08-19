//
//  FilterCell.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/19/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

protocol FilterCellDelegate: class {
    func cell(_ cell: FilterCell, needPerformAction action: FilterCell.Action)
}

class FilterCell: UITableViewCell {

    enum Action {
        case getKeywordSearch(keyword: String)
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel = FilterViewModel()
    weak var delegate: FilterCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollection()
    }

    private func configCollection() {
        collectionView.register(FilterByNameCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension FilterCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(FilterByNameCell.self, forIndexPath: indexPath)
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FilterCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cell(self, needPerformAction: .getKeywordSearch(keyword: viewModel.getKeyWord(at: indexPath)))
    }
}

extension FilterCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthItem: CGFloat = viewModel.keywordSearch[indexPath.row].widthOfString(usingFont: UIFont.systemFont(ofSize: 17)) + 40
        return CGSize(width: widthItem, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
