//
//  DevSecureStorageRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/04/21.
//

import Foundation

class DevSecureStorageRepository: SecureStorageRepository {
    
    var entries: [String: Any] = [:]
    
    func getValue<T>(for key: String) throws -> T {
        guard let value = entries[key] else {
            throw SecureStorageRepositoryError.keyDoesNotExist
        }
        guard let castedValue = value as? T else {
            throw SecureStorageRepositoryError.unableToConvertStoredValueToDesiredType
        }
        return castedValue
    }
    
    func set(value: Any, for key: String) {
        entries[key] = value
    }
    
    func removeValue(for key: String) {
        entries[key] = nil
    }
}
