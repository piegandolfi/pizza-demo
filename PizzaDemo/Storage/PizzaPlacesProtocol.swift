//
//  PizzaPlacesProtocol.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol PizzaPlacesProtocol {
    func getPizzaPlaces() -> [PizzaPlaceModel]
    func getPizzaPlaceBy(id: String) -> PizzaPlaceModel?
    func setPizzaPlaces(_ value: [PizzaPlace])
    func setPizzaPlaceFriends(_ id: String, friendsIds: [String])
    func clearPizzaPlaces()
}
