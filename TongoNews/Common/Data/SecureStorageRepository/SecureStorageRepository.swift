//
//  SecureStorageRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import Foundation

protocol SecureStorageRepository {
    func set(value: Any, for key: String)
    func removeValue(for key: String)
    func getValue<T>(for key: String) throws -> T
}

struct SecureStorageKeys {
    
}

enum SecureStorageRepositoryError: Error {
    case keyDoesNotExist
    case unableToConvertStoredValueToDesiredType
}
