//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

class ImageView: UIImageView, MVVM.View { }

extension UIImageView {

    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: url) else {
                completion(nil)
                return
            }
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: url) { (data, _, error) in
                DispatchQueue.main.async {
                    if let _ = error {
                        completion(nil)
                    } else {
                        if let data = data {
                            let image = UIImage(data: data)
                            completion(image)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
            task.resume()
        }
}
