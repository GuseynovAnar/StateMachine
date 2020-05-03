//
//  ServicesContainer.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation

protocol ServicesContainer {
    var authService: AuthServices { get }
    var homeService: HomeServices { get }
    var userService: UserService { get }
    var storage: StorageServicesContainer { get }
}

class AppServicesContainer: ServicesContainer {
    lazy var authService: AuthServices = BaseAuthServices()
    lazy var homeService: HomeServices = BaseHomeServices()
    lazy var userService: UserService = BaseUserService(secureStorage: storage.secure)
    lazy var storage: StorageServicesContainer = StorageContainer()
}
