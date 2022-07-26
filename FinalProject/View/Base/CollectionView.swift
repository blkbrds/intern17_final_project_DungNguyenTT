//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

extension UICollectionView {
    /** Get notified when UICollectionView has finished asking for data
     http://gg.gg/a5u8h
     */
    func reloadData(moveTop: Bool, completion: (() -> Void)? = nil) {
        if moveTop {
            setContentOffset(CGPoint(x: contentOffset.x, y: 0), animated: false)
        }

        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
            self?.layoutIfNeeded()
        }

        DispatchQueue.main.async {
            completion?()
        }
    }
}
