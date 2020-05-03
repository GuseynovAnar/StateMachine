//
//  UserService.swift
//  StateMachine
//
//  Created by Anar Guseynov on 12.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
enum UserState {
    case unauthorized
    case ready
}
protocol UserService {
    var currentState: UserState { get }
    init(secureStorage: SecureStorage)
}

class BaseUserService: UserService {
    private let storage: SecureStorage
    required init(secureStorage: SecureStorage) {
        self.storage = secureStorage
    }
    
    var currentState: UserState {
        if storage.exist(key: .authToken) {
            return .ready
        } else {
            return .unauthorized
        }
    }
}
