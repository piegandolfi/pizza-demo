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
    func getPizzaPlaces() -> [PizzaPlaceRLM]
    func getPizzaPlaceBy(id: String) -> PizzaPlaceRLM
    func setPizzaPlaces(_ value: [PizzaPlace])
    func setPizzaPlaceFriends(_ id: String, friendsIds: [String])
    func clearPizzaPlaces()
}

protocol PizzaFriendsProtocol {
    func getPizzaFriends() -> [PizzaFriendRLM]
    func getPizzaFriendsBy(ids: [String]) -> [PizzaFriendRLM]
    func setPizzaFriends(_ value: [PizzaFriend])
}
