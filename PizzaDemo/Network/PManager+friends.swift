//
//  PManager+friends.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension PizzaManager {

    func getAllPizzaFriends() -> Observable<[PizzaFriend]> {
        return Observable.create { (observer) -> Disposable in
            let request = self.request(.getAllFriends) { (result) in
                switch result {
                case .success(let response):

                    do {
                        let filteredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                        let pizzaFriends = try filteredResponse.map([PizzaFriend].self)

                        observer.onNext(pizzaFriends)
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
