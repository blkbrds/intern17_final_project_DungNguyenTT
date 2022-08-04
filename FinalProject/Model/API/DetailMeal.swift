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
    var ingredient: [String]?
    var measure: [String]?

    init(json: JSObject) {
        name = json["strMeal"] as? String
        thumb = json["strMealThumb"] as? String
        area = json["strArea"] as? String
        recipe = json["strInstructions"] as? String
        video = json["strYoutube"] as? String
        ingredient = [json["strIngredient1"],
                      json["strIngredient2"],
                      json["strIngredient3"],
                      json["strIngredient4"],
                      json["strIngredient5"],
                      json["strIngredient6"],
                      json["strIngredient7"],
                      json["strIngredient8"],
                      json["strIngredient9"],
                      json["strIngredient10"],
                      json["strIngredient11"],
                      json["strIngredient12"],
                      json["strIngredient13"],
                      json["strIngredient14"],
                      json["strIngredient15"],
                      json["strIngredient16"],
                      json["strIngredient17"],
                      json["strIngredient18"],
                      json["strIngredient19"],
                      json["strIngredient20"]
                    ] as? [String]
        measure = [json["strMeasure1"],
                   json["strMeasure2"],
                   json["strMeasure3"],
                   json["strMeasure4"],
                   json["strMeasure5"],
                   json["strMeasure6"],
                   json["strMeasure7"],
                   json["strMeasure"],
                   json["strMeasure9"],
                   json["strMeasure10"],
                   json["strMeasure11"],
                   json["strMeasure12"],
                   json["strMeasure13"],
                   json["strMeasure14"],
                   json["strMeasure15"],
                   json["strMeasure16"],
                   json["strMeasure17"],
                   json["strMeasure18"],
                   json["strMeasure19"],
                   json["strMeasure20"]
                 ] as? [String]
    }
}
