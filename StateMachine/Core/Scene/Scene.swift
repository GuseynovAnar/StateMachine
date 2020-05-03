//
//  Scene.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit

enum ScenePresentationStyle {
    case newScene
    case push(animated: Bool)
    case pop(animated: Bool)
}

protocol Scene {
    var window: UIWindow? { get }
    var actions: Action? { get set }
    func update(window: UIWindow, style: ScenePresentationStyle)
}

enum SceneType {
    case auth(router: Router, services: ServicesContainer)
    case main(router: Router, services: ServicesContainer)
}

extension SceneType {
    var scene: Scene {
        switch self {
        case let .auth(r, s): return AuthScene(router: r, services: s)
        case let .main(r, s): return HomeScene(router: r, services: s)
        }
    }
}


