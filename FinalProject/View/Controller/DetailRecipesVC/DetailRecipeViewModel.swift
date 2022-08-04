//
//  DetailRecipesViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/2/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class DetailRecipeViewModel {

    private(set) var detailMeal: [DetailMeal] = []

    init(detailMeal: [DetailMeal]) {
        self.detailMeal = detailMeal
    }
}
