//
//  LocalDB.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class LocalDB {
    private var realm: Realm?

    init() {
        realm = try? Realm()
    }
}

extension LocalDB: PizzaPlacesProtocol {
    
    func getPizzaPlaces() -> [PizzaPlaceRLM] {
        return realm!.objects(PizzaPlaceRLM.self).toArray()
    }

    func getPizzaPlaceBy(id: String) -> PizzaPlaceRLM {
        return realm!.objects(PizzaPlaceRLM.self).filter("id = '\(id)'").toArray().first!
    }

    func setPizzaPlaces(_ value: [PizzaPlace]) {

        value.forEach { (pizzaPlace) in
            let placeRLM: PizzaPlaceRLM = PizzaPlaceRLM()

            placeRLM.id = pizzaPlace.id
            placeRLM.name = pizzaPlace.name
            placeRLM.phone = pizzaPlace.phone ?? "\n"
            placeRLM.website = pizzaPlace.website.absoluteString
            placeRLM.formattedAddress = pizzaPlace.formattedAddress
            placeRLM.city = pizzaPlace.city
            pizzaPlace.openingHours.forEach({ placeRLM.openingHours.append($0+"\n") })
            placeRLM.latitude = pizzaPlace.latitude
            placeRLM.longitude = pizzaPlace.longitude
            pizzaPlace.images.forEach({ placeRLM.images.append($0.url.absoluteString)} )
            placeRLM.friendIds.append(objectsIn: pizzaPlace.friendIds)
            placeRLM.rating = "stub" // FIXME: - wrong parameter

            // Description construction
            var placeDescription: String = ""
            placeDescription = pizzaPlace.city+"\n"
            placeDescription.append(pizzaPlace.formattedAddress+"\n")
            placeDescription.append(pizzaPlace.phone ?? "\n")
            placeDescription.append("\n")
            placeDescription.append(pizzaPlace.website.absoluteString+"\n")
            placeDescription.append(pizzaPlace.openingHours.joined(separator: "\n"))
            placeRLM.placeDescription = placeDescription

            try? realm!.write ({
                // If update = false, adds the object
                realm?.add(placeRLM, update: true)
            })
        }
    }
    
    func setPizzaPlaceFriends(_ id: String, friendsIds: [String]) {
        let placeRLM = getPizzaPlaceBy(id: id)
        
        try? realm!.write ({
            placeRLM.friends.append(objectsIn: self.getPizzaFriendsBy(ids: friendsIds))
            // If update = false, adds the object
            realm?.add(placeRLM, update: true)
        })
    }

    func clearPizzaPlaces() {

        // Delete table
        try! realm?.write({
            realm?.deleteAll()
        })
    }
}

extension LocalDB: PizzaFriendsProtocol {
    func getPizzaFriends() -> [PizzaFriendRLM] {
        return realm!.objects(PizzaFriendRLM.self).toArray()
    }
    
    func getPizzaFriendsBy(ids: [String]) -> [PizzaFriendRLM] {
        var pizzaFriends: [PizzaFriendRLM] = []
        ids.forEach { (id) in
            pizzaFriends.append(realm!.objects(PizzaFriendRLM.self).filter("id = '\(id)'").toArray().first!)
        }
        return pizzaFriends
    }
    
    func setPizzaFriends(_ value: [PizzaFriend]) {
        value.forEach { (friend) in
            let friendRLM: PizzaFriendRLM = PizzaFriendRLM()
            
            friendRLM.id = String(friend.id)
            friendRLM.name = friend.name
            friendRLM.avatarURL = friend.avatarUrl
            
            try? realm!.write ({
                // If update = false, adds the object
                realm?.add(friendRLM, update: true)
            })
        }
    }
    
}
