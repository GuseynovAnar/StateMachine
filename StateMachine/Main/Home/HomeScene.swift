//
//  HomeScene.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit

class HomeScene: Scene {
    var actions: Action?
    
    var window: UIWindow?
    private let router: Router
    private let services: ServicesContainer
    init(router: Router, services: ServicesContainer) {
        self.services = services
        self.router = router
    }
    
    func update(window: UIWindow, style: ScenePresentationStyle) {
        self.window = window
        switch style {
        case .newScene:
            window.changeRootViewController(vc: router.rootView, options: .default) {
                self.router.tryFlow(fType: .homeScreen, style: .replace)
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
                self.router.tryFlow(fType: .homeScreen, style: .pop(animated: animated))
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
                self.router.tryFlow(fType: .homeScreen, style: .push(animated: animated))
            }
        }
    }
}
