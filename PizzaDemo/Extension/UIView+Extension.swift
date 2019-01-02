//
//  UIView+Extension.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

extension UIView {
    func fadeIn(_ view: UIView) {
        bounds = view.bounds
        alpha = 0.0
        view.addSubview(self)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        })
    }

    func fadeOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0, delay: 2.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            completion()
        })
    }
}
