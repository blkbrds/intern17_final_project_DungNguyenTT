//
//  RecipesCell.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/26/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class RecipesCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!

    // MARK: - Properties
    var viewModel: RecipesCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Private functions
    private func updateCell() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.item.meal
        let urlString = viewModel.item.mealThumb.unwrapped(or: "")
        imageView.downloadImage(url: urlString) { (image) in
            self.imageView.image = image
        }
    }
}
