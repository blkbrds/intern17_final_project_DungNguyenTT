//
//  FavoritesViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/2/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit
import RealmSwift

final class FavoritesViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel = FavoritesViewModel()

    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Config
    override func setupUI() {
        title = "Favorite"
        tableView.register(FavoritesCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    override func setupData() {
        viewModel.delegate = self
        viewModel.setupObserve()
    }

    // MARK: - Private functions
    private func fetchData() {
        viewModel.fetchData()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FavoritesCell.self)
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        viewModel.deleteMealInRealm(id: viewModel.detailMeals[indexPath.row].id.unwrapped(or: ""))
        viewModel.detailMeals.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }

}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailRecipeVC = DetailRecipeViewController()
        detailRecipeVC.viewModel = DetailRecipeViewModel(id: viewModel.detailMeals[indexPath.row].id.unwrapped(or: ""))
        navigationController?.pushViewController(detailRecipeVC, animated: true)
    }
}

// MARK: - FavoritesViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {

    func viewModel(_ viewModel: FavoritesViewModel, needperfomAction action: FavoritesViewModel.Action) {
        fetchData()
    }
}
