//
//  IngredientView.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/5/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class IngredientView: UIView {

    @IBOutlet private weak var ingredientLabel: UILabel!
    @IBOutlet private weak var measureLabel: UILabel!

    var viewModel: IngredientViewModel? {
        didSet {
             updateCell()
        }
    }

    private func updateCell() {
        guard let viewModel = viewModel else { return }
//        if let ingredients = viewModel.item.ingredient, let measures = viewModel.item.measure {
//            for ingredient in ingredients {
//                ingredientLabel.text = ingredient
//            }
//            for measure in measures {
//                measureLabel.text = measure
//            }
//        }
        ingredientLabel.text = viewModel.igeredient
        measureLabel.text = viewModel.measure
    }
}
