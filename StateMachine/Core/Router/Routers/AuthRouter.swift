//
//  AuthRouter.swift
//  StateMachine
//
//  Created by Anar Guseynov on 03.05.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import UIKit

final class AuthRouter: Router {
    var flows: [Flow] = []
    var rootView: UIViewController?
    
    weak var sceneCoordinator: AppCoordinator?
    
    init(rootView: UIViewController? = nil, sceneCoordinator: AppCoordinator?) {
        self.rootView = rootView
        self.sceneCoordinator = sceneCoordinator
    }
    
    func tryFlow(fType: FlowType, style: FlowPresentation) {
        var isNewFlow = false
        var object = fType.flow
        for flow in flows where type(of: flow) == type(of: fType.flow) {
            isNewFlow = true
            object = flow
        }
        if !isNewFlow { flows.append(object) }
        object.start(router: self, style: style)
    }
}
