//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/25/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class HomeViewModel {

    // MARK: - Defines
    enum RowType: Int, CaseIterable {
        case searchCell = 0
        case categoriesCell
        case recipesCell
    }

    // MARK: - Properties
    private(set) var categories: [Categories] = []
    private(set) var meals: [Meal] = []
    var name: String = ""

    // MARK: - Functions
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRowsInSection() -> Int {
        return RowType.allCases.count
    }

    func heightForRow(at indexPath: IndexPath) -> Int {
        guard let type = RowType(rawValue: indexPath.row) else {
            return 0
        }
        switch type {
        case .searchCell:
            return Config.heightForSearch
        case .categoriesCell:
            return Config.heightForCategoties
        case . recipesCell:
            return Config.heightForRecipes
        }
    }

    func getCategory(completion: @escaping APICompletion) {
        HomeService.getCategories { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.unexpectIssued))
                return
            }
            switch result {
            case .success(let categories):
                this.categories = categories
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getFilterByCategories(name: String, completion: @escaping APICompletion) {
        HomeService.getFilterCategories(category: name.isEmpty ? categories[0].name.unwrapped(or: "") : name) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.unexpectIssued))
                return
            }
            switch result {
            case .success(let meals):
                this.meals = meals
                this.name = name
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForCategories() -> CategoriesCellViewModel {
        return CategoriesCellViewModel(categories: categories)
    }

    func viewModelForFilterByCategories() -> CategoryRecipesCellViewModel {
        var categoryName = ""
        if categories.isNotEmpty && name.isEmpty {
            categoryName = categories[0].name.unwrapped(or: "")
        } else {
            categoryName = name
        }
        return CategoryRecipesCellViewModel(meals: meals, name: categoryName)
    }
}

// MARK: - HomeViewModel
extension HomeViewModel {

    struct Config {
        static let heightForSearch: Int = 130
        static let heightForCategoties: Int = 120
        static let heightForRecipes: Int = Int(screenHeight) - 130 - 120 - 20
    }
}
