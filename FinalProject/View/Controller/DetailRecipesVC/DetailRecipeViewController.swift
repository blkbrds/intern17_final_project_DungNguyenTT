//
//  DetailRecipeViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/2/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class DetailRecipeViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var ingredientView: UIView!
    @IBOutlet private weak var recipeLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var detailView: UIView!

    var viewModel: DetailRecipeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getDetailMeals()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Recipe"
        navigationController?.isNavigationBarHidden = false
    }

    private func configUI() {
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 30
        detailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        guard let meal = viewModel.detailMeal else { return }
        nameMealLabel.text = meal.name
        recipeLabel.text = meal.recipe
        areaLabel.text = meal.area
        let urlString = meal.thumb.unwrapped(or: "")
        imageView.downloadImage(url: urlString) { (image) in
            self.imageView.image = image
        }
        let view1 = IngredientView()
        view1.frame = ingredientView.bounds
        view1.backgroundColor = .red
        ingredientView.addSubview(view1)
    }

    private func getDetailMeals() {
        guard let viewModel = viewModel else { return }
        HUD.show()
        viewModel.getDetailMeals { [weak self] result in
            HUD.dismiss()
            guard let this = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    this.updateView()
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
            }
        }
    }
}
