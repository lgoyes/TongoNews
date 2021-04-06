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
    
    func set<T>(value: T, for key: String) where T : Encodable {
        self.value = value
    }
    
    func removeValue(for key: String) {
        value = nil
    }
    
    func getValue<T: Decodable>(for key: String) throws -> T {
        guard let value = self.value else {
            throw StorageError.keyDoesNotExist
        }
        guard let castedValue = value as? T else {
            throw StorageError.unableToConvertStoredValueToDesiredType
        }
        return castedValue
    }
}
