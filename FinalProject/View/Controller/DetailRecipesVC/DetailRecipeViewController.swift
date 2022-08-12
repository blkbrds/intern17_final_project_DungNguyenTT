//
//  DetailRecipeViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/2/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class DetailRecipeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var ingredientStackView: UIStackView!
    @IBOutlet private weak var recipeLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var detailView: UIView!

    // MARK: - Properties
    var viewModel: DetailRecipeViewModel?

    // MARK: - Life cycle
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

    // MARK: - Private functions
    private func configUI() {
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 30
        detailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBarController?.tabBar.isHidden = true
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
        guard let length = viewModel.detailMeal?.ingredient.count else { return }
        for item in 0..<length {
            let ingredientCustomView = Bundle.main.loadNibNamed("IngredientView", owner: nil, options: nil)?.first as? IngredientView
            ingredientCustomView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
            ingredientCustomView?.viewModel = viewModel.viewModelForItem(at: item)
            ingredientStackView.distribution = .fillEqually
            ingredientStackView.addArrangedSubview(ingredientCustomView ?? UIView())
        }
        favoritesButton.backgroundColor = viewModel.checkIsFavotire() ? UIColor.yellow : UIColor.white
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

    // MARK: - IBActions
    @IBAction private func favoritesButtonTouchUpInside(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        if viewModel.checkIsFavotire() {
            viewModel.deleteFavorites()
        } else {
            viewModel.addFavorites()
        }
        favoritesButton.backgroundColor = viewModel.checkIsFavotire() ? UIColor.yellow : UIColor.white
    }

    @IBAction private func videoButtonTouchUpInside(_ sender: UIButton) {
        guard let video = viewModel?.detailMeal?.video else { return }
        let vc = VideoViewController()
        vc.viewModel = VideoViewModel(url: video)
        navigationController?.pushViewController(vc, animated: true)
    }
}
