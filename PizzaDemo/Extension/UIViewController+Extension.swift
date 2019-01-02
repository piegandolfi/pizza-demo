//
//  UIViewController+Extension.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Shortcut for DispatchQueue.main.asyncAfter(deadline:,execute:)
    ///
    /// - Parameters:
    ///   - delay: delay time.
    ///   - closure: closure block executed after delay.
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + delay, execute: closure)
    }

    func setupUI() {
        let tlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        tlabel.text = self.title ?? self.navigationItem.title
        tlabel.textColor = .black
        tlabel.backgroundColor = .clear
        tlabel.textAlignment = .left
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.autoscale()
        self.navigationItem.titleView = tlabel
        self.navigationItem.largeTitleDisplayMode = .always
    }
}
