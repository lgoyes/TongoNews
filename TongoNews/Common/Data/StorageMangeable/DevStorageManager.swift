//
//  DevSecureStorageRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/04/21.
//

import Foundation

class DevStorageManager: StorageManageable {
    
    var entries: [String: Any] = [:]
    
    func getValue<T: Decodable>(for key: String) throws -> T {
        guard let value = entries[key] else {
            throw StorageError.keyDoesNotExist
        }
        guard let castedValue = value as? T else {
            throw StorageError.unableToConvertStoredValueToDesiredType
        }
        return castedValue
    }
    
    func set<T: Encodable>(value: T, for key: String) {
        entries[key] = value
    }
    
    func removeValue(for key: String) {
        entries[key] = nil
    }
}
