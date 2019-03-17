//
//  PizzaPlaceModel.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 16/03/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import CoreLocation
import Realm

struct PizzaPlaceModel {
    let id: String
    let name: String
    let phone: String
    let website: String
    let formattedAddress: String
    let city: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let rating: String
    let distanceFromCenter: String
    let placeDescription: String
    let friendIds: [String]
    var friends: [PizzaFriendModel]
    let openingHours: [String]
    let images: [String]
}

extension PizzaPlaceModel {
    func toRealm() -> PizzaPlaceRLM {
        let placeRLM: PizzaPlaceRLM = PizzaPlaceRLM()
        
        placeRLM.id = self.id
        placeRLM.name = self.name
        placeRLM.phone = self.phone
        placeRLM.website = self.website
        placeRLM.formattedAddress = self.formattedAddress
        placeRLM.city = self.city
        self.openingHours.forEach({ placeRLM.openingHours.append($0+"\n") })
        placeRLM.latitude = self.latitude
        placeRLM.longitude = self.longitude
        self.images.forEach({ placeRLM.images.append($0)} )
        placeRLM.friendIds.append(objectsIn: self.friendIds)
        placeRLM.rating = "stub" // FIXME: - wrong parameter
        
        // Description construction
        var placeDescription: String = ""
        placeDescription = self.city+"\n"
        placeDescription.append(self.formattedAddress+"\n")
        placeDescription.append(self.phone+"\n")
        placeDescription.append("\n")
        placeDescription.append(self.website+"\n")
        placeDescription.append(self.openingHours.joined(separator: "\n"))
        placeRLM.placeDescription = placeDescription
        
        return placeRLM
    }
}
