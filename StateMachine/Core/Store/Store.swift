//
//  Store.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

protocol Store {
    associatedtype S: State
    associatedtype R: Reducer
    
    var state: S { get }
    var reducer: R { get }
    
    var observable: Observation<S> { get }
    
    init(state: S, reducer: R)
}
