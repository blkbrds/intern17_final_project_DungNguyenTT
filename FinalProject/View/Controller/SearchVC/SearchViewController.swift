//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class SearchViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    var viewModel = SearchViewModel()

    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Override functions
    override func setupUI() {
        tableView.register(FavoritesCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
    }

    // MARK: - Private functions
    private func getMeals(keyword: String) {
        viewModel.getMeals(keyword: keyword) { [weak self] result in
            guard let this = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FavoritesCell.self)
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        cell.favoritesButton.isHidden = true
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.heightForRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailRecipeVC = DetailRecipeViewController()
        detailRecipeVC.viewModel = DetailRecipeViewModel(id: viewModel.filteredMeals[indexPath.row].id.unwrapped(or: ""))
        navigationController?.pushViewController(detailRecipeVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getMeals(keyword: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getMeals(keyword: searchText)
    }
}

// MARK: - Config
extension SearchViewController {

    struct Config {
        static let heightForRow: CGFloat = 80
    }
}
