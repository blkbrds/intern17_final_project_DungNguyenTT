//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import Alamofire

final class Api {
    
    struct CategoryPath: URLStringConvertible {
        let name: String

        init(name: String) {
            self.name = name
        }
        
        var urlString: String {
            return Path.filterPath + name
        }
    }

    struct Path {
        static let baseURL = "https://www.themealdb.com/api/json/v1/1/"
        static let categoriesPath = baseURL + "categories.php"
        static let filterPath = baseURL + "filter.php?c="
        static let byBeefPath = filterPath + "Beef"
        static let byChickenPath = filterPath + "Chicken"
        static let byDessertPath = filterPath + "Dessert"
        static let byLambPath = filterPath + "Lamb"
        static let byLMiscellaneousPath = filterPath + "Miscellaneous"
        static let byPastaPath = filterPath + "Pasta"
        static let byPorkPath = filterPath + "Pork"
        static let bySeafoodPath = filterPath + "Seafood"
        static let bySidePath = filterPath + "Side"
        static let byStarterPath = filterPath + "Starter"
        static let byVeganPath = filterPath + "Vegan"
        static let byVegetarianPath = filterPath + "Vegetarian"
        static let byBreakfastPath = filterPath + "Breakfast"
        static let byGoatPath = filterPath + "Goat"
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending(path: "\(right)")
}
