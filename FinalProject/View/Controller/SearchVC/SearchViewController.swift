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
    var searchTimer: Timer?
    var searchText = ""

    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Override functions
    override func setupUI() {
        tableView.register(FavoritesCell.self)
        tableView.register(FilterCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
    }

    // MARK: - Private functions
    private func getMeals(keyword: String) {
        viewModel.searching = true
        viewModel.getMeals(keyword: keyword) { [weak self] result in
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
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.searching {
            let cell = tableView.dequeue(FavoritesCell.self)
            cell.viewModel = viewModel.viewModelForCell(at: indexPath)
            return cell
        } else {
            tableView.separatorStyle = .none
            let cell = tableView.dequeue(FilterCell.self)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.searching {
            return Config.heightForRow
        } else {
            return Config.heightForFilterRow
        }
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
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        self.searchText = searchText
        searchTimer = Timer.scheduledTimer(timeInterval: Config.timeInterval, target: self, selector: #selector(searchForKeyword(_:)), userInfo: nil, repeats: false)
    }

    @objc func searchForKeyword(_ sender: Any) {
        guard searchText.isNotEmpty else {
            viewModel.searching = false
            viewModel.resetMeal()
            tableView.reloadData()
            return
        }
        getMeals(keyword: searchText)
    }
}

// MARK: - FilterCellDelegate
extension SearchViewController: FilterCellDelegate {
    func cell(_ cell: FilterCell, needPerformAction action: FilterCell.Action) {
        switch  action {
        case .getKeywordSearch(let keyword):
            getMeals(keyword: keyword)
            searchBar.text = keyword
        }
    }
}

// MARK: - Config
extension SearchViewController {

    struct Config {
        static let heightForRow: CGFloat = 80
        static let heightForFilterRow: CGFloat = 200
        static let timeInterval: TimeInterval = 0.5
    }
}
