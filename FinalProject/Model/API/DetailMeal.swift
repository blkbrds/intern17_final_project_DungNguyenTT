//
//  DetailMeal.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/4/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class DetailMeal {

    var name: String?
    var thumb: String?
    var area: String?
    var recipe: String?
    var video: String?
    var ingredient: [String] = []
    var measure: [String] = []

    init(json: JSObject) {
        name = json["strMeal"] as? String
        thumb = json["strMealThumb"] as? String
        area = json["strArea"] as? String
        recipe = json["strInstructions"] as? String
        video = json["strYoutube"] as? String

        for i in 1...20 {
            if let item = json["strIngredient\(i)"] as? String, item != "" {
                ingredient.append(item)
            }
        }

        for j in 1...20 {
            if let item = json["strMeasure\(j)"] as? String, item != "" {
                measure.append(item)
            }
        }
    }
}
