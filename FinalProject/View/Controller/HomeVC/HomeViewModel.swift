//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/25/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class HomeViewModel {

    // MARK: - Define
    enum TypeCell: Int {
        case searchCell = 0
        case categoriesCell
    }

    // MARK: - Functions
    func numberOfSections() -> Int {
        return 2
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }

    func heightCell(at indexPath: IndexPath) -> Int {
        guard let type = TypeCell(rawValue: indexPath.row) else {
            return 0
        }
        switch type {
        case .searchCell:
            return 130
        case .categoriesCell:
            return 100
        }
    }
}
