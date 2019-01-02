//
//  PizzaMarker.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class PizzaMarker: GMSMarker {

    let place: PizzaPlaceViewModel
    let id: String

    init(place: PizzaPlaceViewModel) {
        self.place = place
        self.id = place.id
        super.init()

        position = place.coordinates
        groundAnchor = CGPoint(x: 0.5, y: 1.0)
        appearAnimation = .pop
    }

}
