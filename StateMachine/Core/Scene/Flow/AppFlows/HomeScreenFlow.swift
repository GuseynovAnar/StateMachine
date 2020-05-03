//
//  HomeScreenFlow.swift
//  StateMachine
//
//  Created by Anar Guseynov on 03.05.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import UIKit

class HomeScreenFlow: Flow {
    var router: Router?
    
    private var reducer = HomeReducer()
    private lazy var store = HomeStore(state: .default, reducer: reducer)
    private var view: HomeViewController?
    
    func start(router: Router, style: FlowPresentation) {
        self.router = router
        view = HomeViewController(store)
        view?.changeScene = {
            router.sceneCoordinator?.changeScene(with: .pop(animated: true))
        }
        router.rootView?.tryView(view)
    }
}
