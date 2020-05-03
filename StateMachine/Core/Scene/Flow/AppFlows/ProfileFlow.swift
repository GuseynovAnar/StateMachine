//
//  ProfileFlow.swift
//  StateMachine
//
//  Created by Anar Guseynov on 03.05.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

class ProfileFlow: Flow {
    var router: Router?
    func start(router: Router, style: FlowPresentation) {
        self.router = router
    }
}
