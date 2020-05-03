//
//  AuthReducer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

class AuthReducer: Reducer {
    func mutate(_ state: inout AuthState, newState: AuthState, action: AuthAction)  {
        switch action {
        case .login: state = newState
        case .logout: state = newState
        }
    }
}
