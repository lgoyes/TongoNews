//
//  FakeStorageManageable.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 5/04/21.
//

import Foundation
@testable import TongoNews

class FakeStorageManageable: StorageManageable {
    var value: Any?
    
    func set(value: Any, for key: String) {
        self.value = value
    }
    
    func removeValue(for key: String) {
        value = nil
    }
    
    func getValue<T>(for key: String) throws -> T {
        guard let value = self.value else {
            throw StorageError.keyDoesNotExist
        }
        guard let castedValue = value as? T else {
            throw StorageError.unableToConvertStoredValueToDesiredType
        }
        return castedValue
    }
}
