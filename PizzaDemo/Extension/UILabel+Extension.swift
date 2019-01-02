//
//  UILabel+Extension.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

extension UILabel {
    func autoscale(_ scale: CGFloat = 0.3) {
        self.adjustsFontSizeToFitWidth = true
        self.adjustsFontForContentSizeCategory = true
        self.lineBreakMode = .byClipping
        self.minimumScaleFactor = scale
    }
}
