//
//  String+Extension.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
