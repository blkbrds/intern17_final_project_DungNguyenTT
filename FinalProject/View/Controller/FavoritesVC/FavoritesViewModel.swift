//
//  FavoritesViewModel.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/8/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Protocol
protocol FavoritesViewModelDelegate: class {
    func viewModel(_ viewModel: FavoritesViewModel, needperfomAction action: FavoritesViewModel.Action)
}

final class FavoritesViewModel {

    enum Action {
        case reloadData
    }

    // MARK: - Properties
    var detailMeals: [Meal] = []
    private(set) var notificationToken: NotificationToken?
    weak var delegate: FavoritesViewModelDelegate?

    // MARK: - Public functions
    func numberOfRowsInSection() -> Int {
        return detailMeals.count
    }

    func fetchData(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Meal.self)
            detailMeals = Array(results)
            completion(true)
        } catch {
            completion(false)
        }
    }

    func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Meal.self).observe({ _ in
                self.delegate?.viewModel(self, needperfomAction: .reloadData)
            })
        } catch {
            print(error)
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> FavoritesCellViewModel {
        return FavoritesCellViewModel(meal: detailMeals[indexPath.row])
    }

    func loadDetailView(at indexPath: IndexPath) -> String {
        return detailMeals[indexPath.row].id.unwrapped(or: "")
    }

    func deleteMealInRealm(id: String) {
        do {
            let realm = try Realm()
            guard let results = realm.objects(Meal.self).first(where: { $0.id == id }) else { return }
            try realm.write {
                realm.delete(results)
            }
        } catch {
            print(error)
        }
    }
}
