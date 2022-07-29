//
//  HomeService.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/26/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class HomeService {

    class func getCategories(completion: @escaping Completion<[Categories]>) {
        let urlString = Api.Path.categoriesPath
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data as? JSObject, let items = data["categories"] as? JSArray {
                    var category: [Categories] = []
                    for item in items {
                        category.append(Categories(json: item))
                    }
                    completion(.success(category))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    class func getFilterCategories(category: String, completion: @escaping Completion<[FilterByCategories]>) {
        let urlString = Api.CategoryPath(name: category)
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data as? JSObject, let items = data["meals"] as? JSArray {
                    var meals: [FilterByCategories] = []
                    for item in items {
                        meals.append(FilterByCategories(json: item))
                    }
                    completion(.success(meals))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
