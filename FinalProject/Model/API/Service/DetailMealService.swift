//
//  DetailMealService.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/4/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import ObjectMapper

final class DetailMealService {

    class func getDetailMeal(id: String, completion: @escaping Completion<Meal>) {
        let urlString = Api.MealPath(id: id)
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case . success(let data):
                if let data = data as? JSObject, let items = data["meals"] as? JSArray {
                    guard let meal = Mapper<Meal>().map(JSONObject: items.first) else {
                        completion(.failure(Api.Error.json))
                        return
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
