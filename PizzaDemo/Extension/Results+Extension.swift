//
//  Results+Extension.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Results {
    func toArray() -> [Results.Iterator.Element] {
        return map { $0 }
    }
}
