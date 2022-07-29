//
//  CategorieCell.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate: AnyObject {
    func cell(_ cell: CategorieCell, needPerformAction action: CategorieCell.Action)
}

final class CategorieCell: UICollectionViewCell {

    enum Action {
        case updateCategory
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var categorieLabel: UILabel!
    @IBOutlet private weak var viewImage: UIView!

    // MARK: - Properties
    var viewModel: CategotyCellViewModel? {
        didSet {
            updateView()
        }
    }

    weak var delegate: CategoryCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.layer.masksToBounds = false
    }

    // MARK: - Private function
    private func updateView() {
        guard let viewModel = viewModel else { return }
        categorieLabel.text = viewModel.item.name
        let urlString = viewModel.item.thumb.unwrapped(or: "")
        imageView.downloadImage(url: urlString) { (image) in
            self.imageView.image = image
        }
    }

    // MARK: - IBActions
    @IBAction private func categoriesButtonTouchUpInside(_ sender: UIButton) {
        delegate?.cell(self, needPerformAction: .updateCategory)
        print("tag")
    }
}
