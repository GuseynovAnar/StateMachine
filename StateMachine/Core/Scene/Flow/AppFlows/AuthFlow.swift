//
//  AuthFlow.swift
//  StateMachine
//
//  Created by Anar Guseynov on 03.05.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import UIKit

class AuthFlow: Flow {
    var router: Router?
    
    private var reducer = AuthReducer()
    private lazy var store = AuthStore(state: .default, reducer: reducer)
    private var view: AuthViewController?
    
    func start(router: Router, style: FlowPresentation) {
        self.router = router
        view = AuthViewController(store)
        view?.changeScene = {
            router.sceneCoordinator?.changeScene(with: .push(animated: true))
        }
        router.rootView?.tryView(view)
    }
}
