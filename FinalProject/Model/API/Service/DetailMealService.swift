//
//  DetailMealService.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/4/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class DetailMealService {

    class func getDetailMeal(name: String, completion: @escaping Completion<DetailMeal>) {
        let urlString = Api.MealPath(name: name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case . success(let data):
                if let data = data as? JSObject, let items = data["meals"] as? JSArray {
                    guard let meal = items.first else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    completion(.success(DetailMeal(json: meal)))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
