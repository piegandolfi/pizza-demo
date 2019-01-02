//
//  MapInteractor.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol MapBusinessLogic {
    func requestPizzaPlaces() -> Observable<[PizzaPlaceViewModel]>
    func requestPizzaPlaceByID(_ id: String) -> Observable<PizzaPlaceViewModel>
    func requestPizzaFriends() -> Observable<[PizzaFriendViewModel]>
}

class MapInteractor: BusinessLogic, MapBusinessLogic {
    
    private let networkProvider: PizzaManagerProtocol
    
    private let localDB: (PizzaPlacesProtocol & PizzaFriendsProtocol)!
    
    init(networkProvider: PizzaManagerProtocol = PizzaManager(plugins: [NetworkLoggerPlugin(verbose: true)]), localDB: PizzaPlacesProtocol & PizzaFriendsProtocol = LocalDB()) {
        self.networkProvider = networkProvider
        self.localDB = localDB
    }
    
    func requestPizzaPlaces() -> Observable<[PizzaPlaceViewModel]> {
        return networkProvider.getAllPizzaPlaces()
            .map { [unowned self] (pizzaPlaces) -> [PizzaPlaceRLM] in
                self.localDB.setPizzaPlaces(pizzaPlaces)
                return self.localDB.getPizzaPlaces()
            }
            .map { (pizzaPlacesRLM) -> [PizzaPlaceViewModel] in
                pizzaPlacesRLM.forEach({ (pizzaPlace) in
                    self.localDB.setPizzaPlaceFriends(pizzaPlace.id, friendsIds: pizzaPlace.friendIds.toArray())
                })
                
                return pizzaPlacesRLM.map({ PizzaPlaceViewModel(pizzaPlace: $0) })
        }
    }
    
    func requestPizzaPlaceByID(_ id: String) -> Observable<PizzaPlaceViewModel> {
        return Observable.create({ [weak self] (observer) -> Disposable in
            guard let pizzaPlace = self?.localDB.getPizzaPlaceBy(id: id) else { return Disposables.create() }
            
            observer.onNext(PizzaPlaceViewModel(pizzaPlace: pizzaPlace))
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    
    func requestPizzaFriends() -> Observable<[PizzaFriendViewModel]> {
        return networkProvider.getAllPizzaFriends()
            .map({ [unowned self] (pizzaFriends) -> [PizzaFriendViewModel] in
                self.localDB.setPizzaFriends(pizzaFriends)
                return pizzaFriends.map({ PizzaFriendViewModel(pizzaFriend: $0) })
            })
    }
    
}

