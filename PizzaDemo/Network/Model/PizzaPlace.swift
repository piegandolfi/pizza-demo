//
//  PizzaPlace.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import CoreLocation

struct PizzaPlace: Codable {
    let id: String
    let name: String
    let phone: String?
    let website: URL
    let formattedAddress: String
    let city: String
    let openingHours: [String]
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees
    let images: [PizzaImage]
    let friendIds: [String]
}
