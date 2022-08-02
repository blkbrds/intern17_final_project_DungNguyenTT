//
//  FilterCategories.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/29/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class Meal {

    var name: String?
    var thumb: String?

    init(json: JSObject) {
        name = json["strMeal"] as? String
        thumb = json["strMealThumb"] as? String
    }
}
