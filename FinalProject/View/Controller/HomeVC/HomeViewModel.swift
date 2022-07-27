//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/25/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class HomeViewModel {

    // MARK: - Properties
    private(set) var categories: [Categories] = []

    // MARK: - Defines
    enum RowType: Int, CaseIterable {
        case searchCell = 0
        case categoriesCell
    }

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
            return 130
        case .categoriesCell:
            return 100
        }
    }

    func getCategory(completion: @escaping APICompletion) {
        HomeService.getCategories { [weak self] result in
            if let this = self {
                switch result {
                case .success(let categories):
                    this.categories = categories
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error))
                }
            } else {
                return
            }
        }
    }

    func viewModelForCategories() -> CategoriesCellViewModel {
        return CategoriesCellViewModel(categories: categories)
    }
}
