//
//  AnimationPresenter.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct AnimationPresenter {

    var animationController: UIViewController!

    mutating func present(in viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {

        animationController = UIViewController()
        animationController.view.backgroundColor = .white

        let backgroundView = UIView(frame: viewController.view.frame)
        backgroundView.backgroundColor = UIColor.orange.withAlphaComponent(0.7)
        animationController.view.addSubview(backgroundView)

        let activityIndicatorView = NVActivityIndicatorView(frame: animationController.view.bounds,
                                                            type: .ballClipRotateMultiple,
                                                            color: .white,
                                                            padding: 80.0)
        backgroundView.alpha = 0.0
        activityIndicatorView.alpha = 0.0

        backgroundView.addSubview(activityIndicatorView)
        animationController.modalPresentationStyle = .custom
        animationController.modalTransitionStyle = .crossDissolve

        activityIndicatorView.startAnimating()

        UIView.animate(withDuration: 1.0, animations: {
            backgroundView.alpha = 1.0
            activityIndicatorView.alpha = 1.0
        })

        viewController.present(animationController, animated: animated, completion: completion)
    }

}
