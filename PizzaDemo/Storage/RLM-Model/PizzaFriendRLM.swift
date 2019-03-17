//
//  PizzaFriendRLM.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class PizzaFriendRLM: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var avatarURL: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension PizzaFriendRLM {
    func toModel() -> PizzaFriendModel {
        return PizzaFriendModel(
            id: self.id,
            name: self.name,
            avatarURL: self.avatarURL)
    }
}
