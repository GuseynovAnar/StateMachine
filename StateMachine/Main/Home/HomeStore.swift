//
//  HomeStore.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit

struct HomeState: State {
    var avatarCorner: CGFloat
    
    static let `default` = HomeState(avatarCorner: 20.0)
}

enum HomeAction: Action {
    case rounedCorners
    case circle
}

class HomeStore: Store {
    var state: HomeState {
        didSet {
            observable.value = state
        }
    }
    
    var reducer: HomeReducer
    var observable: Observation<HomeState>
    
    required init(state: HomeState, reducer: HomeReducer) {
        self.state = state
        self.reducer = reducer
        self.observable = Observation<HomeState>(value: state)
    }
    
    func onCircle() {
        let newState = HomeState(avatarCorner: 100)
        reducer.mutate(&state, newState: newState, action: .circle)
    }
    
    func drowRoundedCorners() {
        let newState = HomeState(avatarCorner: 20)
        reducer.mutate(&state, newState: newState, action: .rounedCorners)
    }
}
