//
//  DetailMealService.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/4/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class DetailMealService {

    func getDetailMeal(name: String, completion: @escaping Completion<[DetailMeal]>) {
        let urlString = Api.MealPath(name: name)
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case . success(let data):
                if let data = data as? JSObject, let items = data["meals"] as? JSArray {
                    var meal: [DetailMeal] = []
                    for item in items {
                        meal.append(DetailMeal(json: item))
                    }
                    completion(.success(meal))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
