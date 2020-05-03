//
//  AppRouter.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import UIKit

protocol Router {
    var sceneCoordinator: AppCoordinator? { get }
    var flows: [Flow] { get }
    var rootView: UIViewController? { get }
    func tryFlow(fType: FlowType, style: FlowPresentation)
}
