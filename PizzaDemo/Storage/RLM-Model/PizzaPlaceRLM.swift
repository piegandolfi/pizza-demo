//
//  PizzaPlaceRLM.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import CoreLocation
import Realm
import RealmSwift

class PizzaPlaceRLM: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var formattedAddress: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var latitude: CLLocationDegrees = 0.0
    @objc dynamic var longitude: CLLocationDegrees = 0.0
    @objc dynamic var rating: String = ""
    @objc dynamic var distanceFromCenter: String = ""
    @objc dynamic var placeDescription: String = ""
    var friendIds = List<String>()
    var friends = List<PizzaFriendRLM>()
    var openingHours = List<String>()
    var images = List<String>()


    override static func primaryKey() -> String? {
        return "id"
    }
}
