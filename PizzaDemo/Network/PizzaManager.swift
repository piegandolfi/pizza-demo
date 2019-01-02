//
//  PizzaManager.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol PizzaManagerProtocol {
    func getAllPizzaPlaces() -> Observable<[PizzaPlace]>
    func getPizzaPlace(id: String) -> Observable<PizzaPlace>
    func getAllPizzaFriends() -> Observable<[PizzaFriend]>
}

class PizzaManager: MoyaProvider<PizzaService>, PizzaManagerProtocol {
    let disposeBag = DisposeBag()
}
