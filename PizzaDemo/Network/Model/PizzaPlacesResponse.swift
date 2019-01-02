//
//  PizzaPlacesResponse.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation

struct PizzaPlacesResponse: Codable {
    let meta: PizzaMeta
    let list: PizzaList
}
