//
//  AlertPresenter.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

enum AlertType {
    case search
    case options
    case bookmark
    case readMore
    case bookNow
    case error
}

struct AlertPresenter {

    let type: AlertType
    let error: Error?

    init(_ type: AlertType, error: Error? = nil) {
        self.type = type
        self.error = error
    }

    func present(in viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: fillInformarions().title, message: fillInformarions().message, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: animated, completion: completion)
    }

    private func fillInformarions() -> (title: String, message: String) {
        switch type {
        case .search:
            return ("Search", "This feature will be available soon!")
        case .options:
            return ("Options", "This feature will be available soon!")
        case .bookmark:
            return ("Add to bookmark", "Do you want to add this to your bookmark?")
        case .readMore:
            return ("Read more", "This feature will be available soon!")
        case .bookNow:
            return ("Book now!", "Do you want to reserve a table here?")
        case .error:
            guard let error = error else { return ("Error", "Unknown") }
            return ("Error", error.localizedDescription)
        }
    }

}
