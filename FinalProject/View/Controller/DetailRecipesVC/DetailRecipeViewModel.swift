//
//  DetailRecipesViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/2/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class DetailRecipeViewModel {

    private(set) var detailMeal: DetailMeal?
    private(set) var name: String

    init(name: String) {
        self.name = name
    }

    func getDetailMeals(completion: @escaping APICompletion) {
        DetailMealService.getDetailMeal(name: name) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.unexpectIssued))
                return
            }
            switch result {
            case .success(let detailMeal):
                this.detailMeal = detailMeal
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForItem(at index: Int) -> IngredientViewModel {
        return IngredientViewModel(ingredient: detailMeal?.ingredient[index] ?? "", measure: detailMeal?.measure[index] ?? "")
    }
}
