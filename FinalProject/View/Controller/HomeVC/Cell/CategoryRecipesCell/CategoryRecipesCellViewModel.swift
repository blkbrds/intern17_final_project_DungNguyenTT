//
//  CategoryRecipesCellViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/25/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class CategoryRecipesCellViewModel {

    // MARK: - Properties
    private(set) var meals: [FilterByCategories] = []
    private(set) var name: String = ""

    init(meals: [FilterByCategories], name: String) {
        self.meals = meals
        self.name = name
    }

    // MARK: - Public functions
    func numberOfItemsInSection() -> Int {
        return meals.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> RecipesCellViewModel {
        return RecipesCellViewModel(item: meals[indexPath.row])
    }
}
