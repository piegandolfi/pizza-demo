//
//  StarView.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

class StarView: UIStackView {
    func showStarCount(_ totalStarCount: Int, animated: Bool = true) {
        let starsToAdd = totalStarCount - arrangedSubviews.count

        if starsToAdd > 0 {
            for _ in 1...starsToAdd {
                let starImageView = UIImageView(image: UIImage(named: "ratingStar"))
                starImageView.contentMode = .scaleAspectFit
                starImageView.frame.origin = CGPoint(x: frame.width, y: 0)
                addArrangedSubview(starImageView)
            }
        } else if starsToAdd < 0 {
            let starsToRemove = abs(starsToAdd)

            for _ in 1...starsToRemove {
                guard let star = arrangedSubviews.last else {
                    fatalError("Unexpected Logic Error")
                }
                star.removeFromSuperview()
            }
        }

        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            })
        }
        
        axis = .horizontal
        alignment = .leading
    }
}
