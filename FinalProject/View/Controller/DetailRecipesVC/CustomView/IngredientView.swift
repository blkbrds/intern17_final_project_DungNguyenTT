//
//  IngredientView.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/5/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class IngredientView: UIView {

    // MARK: - IBOutletd
    @IBOutlet private weak var ingredientLabel: UILabel!
    @IBOutlet private weak var measureLabel: UILabel!

    // MARK: - Properties
    var viewModel: IngredientViewModel? {
        didSet {
             updateCell()
        }
    }

    // MARK: - Privte function
    private func updateCell() {
        guard let viewModel = viewModel else { return }
        ingredientLabel.text = viewModel.ingredient
        measureLabel.text = "- " + viewModel.measure
    }
}
