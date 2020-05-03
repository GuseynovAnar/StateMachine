//
//  AuthStore.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

struct AuthState: State {
    var name: String
    var password: String
    var authorized: Bool
    
    static let `default` = AuthState(name: "", password: "", authorized: false)
}

enum AuthAction: Action {
    case login
    case logout
}

class AuthStore: Store {
    
    var state: AuthState {
        didSet {
            observable.value = state
        }
    }
    
    var reducer: AuthReducer
    var observable: Observation<AuthState>
    
    required init(state: AuthState, reducer: AuthReducer) {
        self.state = state
        self.reducer = reducer
        self.observable = Observation<S>(value: state)
    }
    
    func login() {
        let newState = AuthState(name: "Anar", password: "1234", authorized: true)
        reducer.mutate(&state, newState: newState, action: .login)
    }
    
    func logout() {
        let newState = AuthState(name: "", password: "", authorized: false)
        reducer.mutate(&state, newState: newState, action: .logout)
    }
}
