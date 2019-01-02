//
//  PManager+pizzaPlaces.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension PizzaManager {

    func getAllPizzaPlaces() -> Observable<[PizzaPlace]> {
        return Observable.create { (observer) -> Disposable in
            let request = self.request(.getAllPizzaPlaces) { (result) in
                switch result {
                case .success(let response):

                    do {
                        let filteredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                        let pizzaPlacesResponse = try filteredResponse.map(PizzaPlacesResponse.self)
                        let pizzaPlaces = pizzaPlacesResponse.list.places

                        observer.onNext(pizzaPlaces)
                        observer.onCompleted()

                    } catch {
                        observer.onError(error)
                    }

                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func getPizzaPlace(id: String) -> Observable<PizzaPlace> {
        return Observable.create { (observer) -> Disposable in
            let request = self.request(.getPizzaPlace(id: id)) { (result) in
                switch result {
                case .success(let response):

                    do {
                        let filteredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                        let pizzaPlace = try filteredResponse.map(PizzaPlace.self)

                        observer.onNext(pizzaPlace)
                        observer.onCompleted()

                    } catch {
                        observer.onError(error)
                    }

                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
