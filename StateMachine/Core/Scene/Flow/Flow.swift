//
//  Flow.swift
//  StateMachine
//
//  Created by Anar Guseynov on 12.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit

enum FlowPresentation {
    case popToRoot(animated: Bool)
    case popToView(animated: Bool)
    case pop(animated: Bool)
    case push(animated: Bool)
    case replace
}

protocol Flow {
    var router: Router? { get }
    func start(router: Router, style: FlowPresentation)
}

enum FlowType {
    case auth
    case homeScreen
    case profile
    case feed
}

extension FlowType {
    var flow: Flow {
        switch self {
        case .auth: return AuthFlow()
        case .feed: return FeedFlow()
        case .homeScreen: return HomeScreenFlow()
        case .profile: return ProfileFlow()
        }
    }
}
