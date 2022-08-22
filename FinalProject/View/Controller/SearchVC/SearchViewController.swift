//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func viewControler(_ viewControler: SearchViewController, needPerformAction action: SearchViewController.Action)
}

final class SearchViewController: ViewController {

    enum Action {
        case getKeywordSearch(keyword: String)
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    var viewModel = SearchViewModel()
    var searchTimer: Timer?
    var searchText = ""
    weak var delegate: SearchViewControllerDelegate?

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
        tableView.register(HistorySearchCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
    }

    // MARK: - Private functions
    private func getMeals() {
        viewModel.searching = true
        viewModel.getMeals { [weak self] result in
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

    override func setupData() {
        setupObserve()
    }

    private func setupObserve() {
        viewModel.setupObserve { (done) in
            DispatchQueue.main.async {
                if done {
                    self.tableView.reloadData()
                } else {
                    self.alert(msg: "Error", handler: nil)
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.searching {
            let cell = tableView.dequeue(FavoritesCell.self)
            cell.viewModel = viewModel.viewModelForCell(at: indexPath)
            return cell
        } else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeue(FilterCell.self)
                cell.delegate = self
                return cell
            default:
                let cell = tableView.dequeue(HistorySearchCell.self)
                cell.viewModel = viewModel.getHistory(at: indexPath)
                cell.delegate = self
                return cell
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.searching {
            tableView.deselectRow(at: indexPath, animated: true)
            let detailRecipeVC = DetailRecipeViewController()
            detailRecipeVC.viewModel = DetailRecipeViewModel(id: viewModel.filteredMeals[indexPath.row].id.unwrapped(or: ""))
            navigationController?.pushViewController(detailRecipeVC, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            delegate?.viewControler(self, needPerformAction: .getKeywordSearch(keyword: viewModel.history[indexPath.row].keyword))
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.keyword = searchBar.text ?? ""
        getMeals()
        let checkIsHistorySearch = viewModel.checkIsHistorySearch()
        if checkIsHistorySearch == false {
            viewModel.saveHistorySearch()
        }
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
        viewModel.keyword = searchText
        getMeals()
    }
}

// MARK: - FilterCellDelegate
extension SearchViewController: FilterCellDelegate {
    func cell(_ cell: FilterCell, needPerformAction action: FilterCell.Action) {
        switch  action {
        case .getKeywordSearch(let keyword):
            viewModel.keyword = keyword
            getMeals()
            searchBar.text = keyword
        }
    }
}

// MARK: - HistorySearchCellDelegate
extension SearchViewController: HistorySearchCellDelegate {
    func cell(_ cell: HistorySearchCell, needPerformAction action: HistorySearchCell.Action) {
        switch action {
        case .deleteHistory(let key):
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            viewModel.deleteHistorySearch(key: key)
            viewModel.history.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - SearchViewControllerDelegate
extension SearchViewController: SearchViewControllerDelegate {

    func viewControler(_ viewControler: SearchViewController, needPerformAction action: Action) {
        switch action {
        case .getKeywordSearch(let keyword):
            viewModel.keyword = keyword
            getMeals()
            searchBar.text = keyword
        }
    }
}

// MARK: - Config
extension SearchViewController {

    struct Config {
        static let timeInterval: TimeInterval = 0.5
    }
}
