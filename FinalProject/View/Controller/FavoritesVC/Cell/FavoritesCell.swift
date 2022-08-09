//
//  RevoritesCell.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/8/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet weak var nameMealLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
