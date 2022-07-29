//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 7/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class HomeViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: HomeViewModel?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Config
    override func setupUI() {
        tableView.register(SearchCell.self)
        tableView.register(CategoriesCell.self)
        tableView.register(CategoryRecipesCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func setupData() {
        getCategory()
    }

    // MARK: - Private functions
    private func getCategory() {
        HUD.show()
        viewModel?.getCategory(completion: { [weak self] result in
            HUD.dismiss()
            guard let this = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    this.getFilterByCategories()
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
            }
        })
    }

    private func getFilterByCategories(name: String = "") {
        guard let viewModel = viewModel else { return }
        HUD.show()
        viewModel.getFilterByCategories(name: name) { [weak self] result in
            HUD.dismiss()
            guard let this = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    this.tableView.reloadData()
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = HomeViewModel.RowType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        switch type {
        case .searchCell:
            let searchCell = tableView.dequeue(SearchCell.self)
            return searchCell
        case .categoriesCell:
            let categoriesCell = tableView.dequeue(CategoriesCell.self)
            categoriesCell.detegate = self
            categoriesCell.viewModel = viewModel.viewModelForCategories()
            return categoriesCell
        case .recipesCell:
            let recipesCell = tableView.dequeue(CategoryRecipesCell.self)
            recipesCell.viewModel = viewModel.viewModelForFilterByCategories()
            return recipesCell
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }
        return CGFloat(viewModel.heightForRow(at: indexPath))
    }
}

// MARK: - CategoriesCellDelegate
extension HomeViewController: CategoriesCellDelegate {
    func cell(_ cell: CategoriesCell, needPerformAction action: CategoriesCell.Action) {
        switch action {
        case .loadNewRecipes(let name):
            getFilterByCategories(name: name)
        }
    }
}
