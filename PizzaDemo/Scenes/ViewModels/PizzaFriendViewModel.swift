//
//  PizzaFriendViewModel.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

struct PizzaFriendViewModel {
    let id: Int
    let name: String
    var avatarURL: URL
    
    init(pizzaFriend: PizzaFriend) {
        self.id = pizzaFriend.id
        self.name = pizzaFriend.name
        self.avatarURL = URL(string: pizzaFriend.avatarUrl)!
    }
}

