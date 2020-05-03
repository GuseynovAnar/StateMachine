//
//  AppScenesRouterContainer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 03.05.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import UIKit

enum RouterType {
    case authRouter(_ rootView: UIViewController? = UIViewController())
    case mainRouter(rootView: UIViewController?)
}

extension RouterType {
    var rootView: UIViewController? {
        switch self {
        case let .authRouter(rootView): return rootView
        case let .mainRouter(rootView): return rootView
        }
    }
}

protocol ScenesRouterContainer {
    var rootCoordinator: AppCoordinator? { get }
    var routersType: [RouterType] { get }
    
    var authRouter: Router? { get }
    var mainRouter: Router? { get }
    
    init(routersType: [RouterType], rootCoordinator: AppCoordinator?)
}

class AppScenesRouterContainer: ScenesRouterContainer {
    var authRouter: Router? {
        let auth = routersType.compactMap { t -> RouterType? in
            if case .authRouter = t { return t }
            return nil
        }.first
        guard let a = auth else { return nil }
        return AuthRouter(rootView: a.rootView, sceneCoordinator: rootCoordinator)
    }
    
    var mainRouter: Router? {
        let main = routersType.compactMap { t -> RouterType? in
            if case .mainRouter = t { return t }
            return nil
        }.first
        guard let m = main else { return nil }
        return MainRouter(rootView: m.rootView, sceneCoordinator: rootCoordinator)
    }
    
    var routersType: [RouterType]
    
    weak var rootCoordinator: AppCoordinator?
    
    required init(routersType: [RouterType], rootCoordinator: AppCoordinator?) {
        self.routersType = routersType
        self.rootCoordinator = rootCoordinator
    }
}
