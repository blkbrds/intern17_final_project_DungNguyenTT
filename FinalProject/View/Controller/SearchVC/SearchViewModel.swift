//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class SearchViewModel {

    // MARK: - Properties
    private(set) var filteredMeals: [Meal] = []

    // MARK: - Public functions
    func numberOfRowsInSection() -> Int {
        return filteredMeals.count
    }

    func getMeals(keyword: String, completion: @escaping APICompletion) {
        SearchService.getMeal(keyword: keyword) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.unexpectIssued))
                return
            }
            switch result {
            case .success(let filteredMeals):
                this.filteredMeals = filteredMeals
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> FavoritesCellViewModel {
        return FavoritesCellViewModel(meal: filteredMeals[indexPath.row])
    }
}
