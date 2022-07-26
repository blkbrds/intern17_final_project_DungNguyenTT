//
//  SearchCell.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class SearchCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Property
    var viewModel = SearchCellViewModel()

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Private function
    private func configUI() {
        self.titleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: "Make your own food, \nstay at home")
        let myRange = NSRange(location: 29, length: 4)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemYellow, range: myRange)
        titleLabel.attributedText = attrString
    }
}
