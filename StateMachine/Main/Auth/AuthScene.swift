//
//  AuthScene.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit


class AuthScene: Scene {
    var actions: Action?
    
    var window: UIWindow?
    private let router: Router
    private let services: ServicesContainer
    init(router: Router, services: ServicesContainer) {
        self.router = router
        self.services = services
    }
    
    func update(window: UIWindow, style: ScenePresentationStyle) {
        self.window = window
        switch style {
        case .newScene:
            window.changeRootViewController(vc: router.rootView, options: .default) {
                self.router.tryFlow(fType: .auth, style: .replace)
            }
        case let .pop(animated):
            window.changeRootViewController(
                vc: router.rootView,
                options: .init(
                    duration: animated ? 0.2 : 0.0,
                    direction: .toLeft,
                    style: .linear,
                    transitionType: .moveIn
                )
            ) {
                self.router.tryFlow(fType: .auth, style: .pop(animated: animated))
            }
        case let .push(animated):
            window.changeRootViewController(
                vc: router.rootView,
                options: .init(
                    duration: animated ? 0.2 : 0.0,
                    direction: .toRight,
                    style: .linear,
                    transitionType: .push
                )
            ) {
                self.router.tryFlow(fType: .auth, style: .push(animated: animated))
            }
        }
    }
}
