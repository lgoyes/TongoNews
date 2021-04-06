//
//  ProdSecureStorageManager.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 5/04/21.
//

import Foundation
import KeychainAccess

class ProdSecureStorageManager: StorageManageable {
    private struct Service {
        static let test = "com.tongo.TongoNews.test"
        static let dev = "com.tongo.TongoNews.dev"
        static let prod = "com.tongo.TongoNews"
    }
    
    private var keychain: Keychain
    init(systemConfig: SystemConfig) {
        var service: String
        
        switch systemConfig {
        case .dev:
            service = Service.dev
        case .prod:
            service = Service.prod
        case .test:
            service = Service.test
        }
        keychain = Keychain(service: service)
    }
    
    func set<T: Encodable>(value: T, for key: String) {
        keychain[data: key] = try! JSONEncoder().encode(value)
    }
    
    func removeValue(for key: String) {
        keychain[key] = nil
    }
    
    func getValue<T: Decodable>(for key: String) throws -> T {
        guard let value = keychain[data: key] else {
            throw StorageError.keyDoesNotExist
        }
        guard let castedValue = try? JSONDecoder().decode(T.self, from: value) else {
            throw StorageError.unableToConvertStoredValueToDesiredType
        }
        return castedValue
    }
    
    // MARK: - Testing
    
    func supersed(keychain: Keychain) {
        self.keychain = keychain
    }
    
    func getKeychain() -> Keychain {
        return self.keychain
    }
}
