//
//  FilterCategories.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/29/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class FilterByCategories {

    var meal: String?
    var mealThumb: String?

    init(json: JSObject) {
        meal = json["strMeal"] as? String
        mealThumb = json["strMealThumb"] as? String
    }
}
