//
//  UIViewController+Extensions.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import UIKit

extension UIViewController {
    var visibleController: UIViewController {
        switch self {
        case is UINavigationController:
            return (self as? UINavigationController)?.visibleViewController ?? self
        case is UITabBarController:
            return (self as? UITabBarController)?.selectedViewController ?? self
        default:
            return presentedViewController ?? self
        }
    }
    
    func tryView(_ view: UIViewController?) {
        guard let view = view else { return }
        if type(of: self) == UINavigationController.self {
            let navigation = self as? UINavigationController
            navigation?.viewControllers = [view]
            return
        }
        if type(of: self) == UIViewController.self {
            self.addChild(view)
            self.view.addSubview(view.view)
            view.didMove(toParent: self)
            return
        }
    }
}
