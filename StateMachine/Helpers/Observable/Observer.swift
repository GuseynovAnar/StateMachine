//
//  Observer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

protocol Observable {
    associatedtype Model
    var uuid: UUID { get }
    var onValueChange: (Model) -> Void { get }
}

protocol Observer {
    associatedtype M: Observable
    var observables: [M] { get }
    func subscribe<T: AnyObject>(_ target: T?, completion: @escaping (T, M.Model) -> Void)
}

struct ObservableObject<M: Equatable>: Observable  {
    var uuid: UUID
    var onValueChange: (M) -> Void
}

class Observation<O: Equatable>: Observer {
    var value: ObservableObject<O>.Model {
        didSet { notify(value: value, oldValue: oldValue) }
    }
    
    var observables: [ObservableObject<O>] = []
    
    init(value: ObservableObject<O>.Model) {
        self.value = value
    }
    
    func subscribe<T: AnyObject>(_ target: T?, completion: @escaping (T, ObservableObject<O>.Model) -> Void) {
        let uuid = UUID()
        observables.append(
            ObservableObject<O>(uuid: uuid, onValueChange: { [weak self, weak target] value in
                guard let target = target else {
                    self?.observables.removeAll(where: { $0.uuid == uuid })
                    return
                }
                completion(target, value)
            })
        )
    }
    
    private func notify(value: ObservableObject<O>.Model, oldValue: ObservableObject<O>.Model?) {
        guard oldValue != value else { return }
        observables.enumerated().forEach { $0.element.onValueChange(value) }
    }
    
    deinit {
        observables.removeAll()
    }
}
