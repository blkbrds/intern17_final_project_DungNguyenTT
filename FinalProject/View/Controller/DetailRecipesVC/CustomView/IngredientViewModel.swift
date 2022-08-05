//
//  File.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/5/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class IngredientViewModel {

    // MARK: - Properties
//    private(set) var item: DetailMeal
    private(set) var igeredient: String
    private(set) var measure: String

    init(igeredient: String, measure: String) {
//        self.item = item
        self.igeredient = igeredient
        self.measure = measure
    }
}
