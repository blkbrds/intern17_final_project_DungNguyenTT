//
//  Categories.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/26/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class Categories {

    var strCategory: String?
    var strCategoryThumb: String?

    init(json: JSObject) {
        strCategory = json["strCategory"] as? String
        strCategoryThumb = json["strCategoryThumb"] as? String
    }
}
