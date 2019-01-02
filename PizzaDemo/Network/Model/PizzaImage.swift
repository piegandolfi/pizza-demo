//
//  PizzaImage.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation

struct PizzaImage: Codable {
    let id: String
    let url: URL
    let caption: String
    let expiration: String // UTC Date formatted into String
}
