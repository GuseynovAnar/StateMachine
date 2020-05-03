//
//  Reducer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

protocol Action { }
typealias State = Equatable

protocol Reducer {
    associatedtype S: State
    associatedtype A: Action
    func mutate(_ state: inout S, newState: S, action: A)
}
