//
//  PizzaPlaceViewModel.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import CoreLocation

struct PizzaPlaceViewModel {
    let id: String
    let name: String
    let description: String
    let coordinates: CLLocationCoordinate2D
    let distanceFromCenter: String
    let imagesURL: [URL?]
    let friendsURL: [URL?]
    let rating: String

    init(pizzaPlace: PizzaPlaceRLM, location: CLLocation? = nil) {
        self.id = pizzaPlace.id
        self.name = pizzaPlace.name
        self.description = pizzaPlace.placeDescription
        self.coordinates = CLLocationCoordinate2DMake(pizzaPlace.latitude, pizzaPlace.longitude)
        
        if let location = location {
            let distance = location.distance(from: CLLocation(
                latitude: pizzaPlace.latitude,
                longitude: pizzaPlace.longitude))
            let roundedDistance = Double(round(distance/1000))
            
            self.distanceFromCenter = String(roundedDistance)
        } else {
            self.distanceFromCenter = "Unknown"
        }
        
        self.imagesURL = pizzaPlace.images.map({ URL(string: $0)! })
        self.friendsURL = pizzaPlace.friends.map({ URL(string: $0.avatarURL) })
        self.rating = pizzaPlace.rating
    }
}
