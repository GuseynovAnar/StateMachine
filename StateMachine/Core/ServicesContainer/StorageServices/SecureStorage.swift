//
//  SecureStorage.swift
//  StateMachine
//
//  Created by Anar Guseynov on 12.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import KeychainSwift

enum SocialNetwork: String, Equatable { case vk, fb, ok, apple }

enum SecureStorageKeys: String, CaseIterable {
    case authToken

    case vkToken
    case fbToken
    case okToken
    case appleToken

    case test
    case pushToken
}

extension SecureStorageKeys {
    init(social: SocialNetwork) {
        switch social {
        case .vk:
            self = .vkToken
        case .fb:
            self = .fbToken
        case .ok:
            self = .okToken
        case .apple:
            self = .appleToken
        }
    }
}

protocol SecureStorage {
    func save(value: String, key: SecureStorageKeys, callback: () -> Void)
    func load(key: SecureStorageKeys) -> String?
    func exist(key: SecureStorageKeys) -> Bool
    func remove(key: SecureStorageKeys)
    func removeAll()
    func removeAll(except: SecureStorageKeys)
}

class KeychainStorage: SecureStorage {
    func removeAll() {
        KeychainSwift().clear()
    }

    func removeAll(except: SecureStorageKeys) {
        SecureStorageKeys.allCases.forEach {
            if $0 != except {
                KeychainSwift().delete($0.rawValue)
            }
        }
    }

    func save(value: String, key: SecureStorageKeys, callback: () -> Void) {
        var succeed = false
        while !succeed {
            succeed = KeychainSwift().set(value, forKey: key.rawValue, withAccess: nil)
        }
        callback()
    }

    func load(key: SecureStorageKeys) -> String? {
        return KeychainSwift().get(key.rawValue)
    }

    func exist(key: SecureStorageKeys) -> Bool {
        return KeychainSwift().get(key.rawValue) != nil
    }

    func remove(key: SecureStorageKeys) {
        KeychainSwift().delete(key.rawValue)
    }
}

