//
//  StorageServicesContainer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 12.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

protocol StorageServicesContainer {
    var secure: SecureStorage { get }
}

class StorageContainer: StorageServicesContainer {
    lazy var secure: SecureStorage = KeychainStorage()
}
