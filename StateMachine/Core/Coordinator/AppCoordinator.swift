//
//  AppCoordinator.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit

enum SceneState: Equatable {
    case none
    case auth
    case main
}

final class AppCoordinator {
    private let window: UIWindow
    private var scenes: [Scene] = []
    private var currentState: SceneState = .none
    
    private lazy var serviceContainer: ServicesContainer = AppServicesContainer()
    private lazy var routersContainer: ScenesRouterContainer = AppScenesRouterContainer(
        routersType: [.authRouter(), .mainRouter(rootView: UINavigationController())], rootCoordinator: self
    )
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        switch serviceContainer.userService.currentState {
        case .ready: changeScene(with: .push(animated: true))
        case .unauthorized: changeScene(with: .newScene)
        }
    }
    
    func changeScene(with style: ScenePresentationStyle) {
        switch currentState {
        case .auth:
            tryScene(
                sType: .main(router: routersContainer.mainRouter!, services: serviceContainer),
                style: style
            )
        case .main:
            tryScene(
                sType: .auth(router: routersContainer.authRouter!, services: serviceContainer),
                style: style
            )
        case .none:
            tryScene(
                sType: .auth(router: routersContainer.authRouter!, services: serviceContainer),
                style: style
            )
        }
    }
    
    private func tryScene(sType: SceneType, style: ScenePresentationStyle) {
        var isNewScene = false
        var object = sType.scene
        for scene in scenes where type(of: scene) == type(of: sType.scene) {
            isNewScene = true
            object = scene
        }
        if !isNewScene {
            scenes.append(object)
        }
        
        switch sType {
        case .auth: currentState = .auth
        case .main: currentState = .main
        }
        
        object.update(window: window, style: style)
    }
}
