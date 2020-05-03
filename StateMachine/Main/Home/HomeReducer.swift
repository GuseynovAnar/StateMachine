//
//  HomeReducer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

class HomeReducer: Reducer {
    func mutate(_ state: inout HomeState, newState: HomeState, action: HomeAction) {
        switch action {
        case .circle: state = newState
        case .rounedCorners: state = newState
        }
    }
}
