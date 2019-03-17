//
//  PlaceDetailsInteractor.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

protocol PlaceDetailsBusinessLogic {
    func loadPlaceDetails(id: String) -> Observable<PizzaPlaceViewModel>
}

class PlaceDetailsInteractor: BusinessLogic, PlaceDetailsBusinessLogic {

    private let localDB: (PizzaPlacesProtocol & PizzaFriendsProtocol)!

    init(localDB: PizzaPlacesProtocol & PizzaFriendsProtocol = LocalDB()) {
        self.localDB = localDB
    }

    func loadPlaceDetails(id: String) -> Observable<PizzaPlaceViewModel> {
        return Observable.create({ [weak self] (observer) -> Disposable in
            guard let strongSelf = self else { return Disposables.create() }
            let amsterdamCenter: CLLocation = CLLocation(latitude: 52.3679636, longitude: 4.8335219)
            let pizzaPlace = PizzaPlaceViewModel(pizzaPlace: strongSelf.localDB.getPizzaPlaceBy(id: id)!, location: amsterdamCenter)

            observer.onNext(pizzaPlace)
            observer.onCompleted()

            return Disposables.create()
        })
    }

}
