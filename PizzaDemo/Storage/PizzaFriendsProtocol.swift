//
//  PizzaFriendsProtocol.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 16/03/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation

protocol PizzaFriendsProtocol {
    func getPizzaFriends() -> [PizzaFriendModel]
    func getPizzaFriendsBy(ids: [String]) -> [PizzaFriendModel]
    func setPizzaFriends(_ value: [PizzaFriend])
}
