//
//  PizzaService.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import Moya

enum PizzaService {
    case getAllPizzaPlaces
    case getPizzaPlace(id: String)
    case getAllFriends
}

extension PizzaService: TargetType {

    var baseURL: URL {

        guard let urlFromString = URL(string: "http://demo5563234.mockable.io/pizza-api") else {
            fatalError("Impossible to create an URL")
        }

        return urlFromString
    }

    var path: String {
        switch self {

        case .getAllPizzaPlaces:
            return "/pizzaplaces"

        case .getPizzaPlace(let id):
            return "/pizzaplaces/\(id)"

        case .getAllFriends:
            return "/friends"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any] {
        switch self {

        case .getPizzaPlace(let id):
            return ["": id]

        default:
            return [:]
        }
    }

    var task: Task {
        switch self {

        case .getPizzaPlace:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var sampleData: Data {
        /// Sample data encoding, always in UTF8.
        return "{}".utf8Encoded
    }

}
