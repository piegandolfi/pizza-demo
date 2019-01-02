//
//  UIButton+Extension.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

extension UIButton: Roundable {

    func roundMe() {
        layer.cornerRadius = 8
    }

}
