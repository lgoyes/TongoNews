//
//  StorageManageable.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import Foundation

protocol StorageManageable {
    func set<T: Encodable>(value: T, for key: String)
    func removeValue(for key: String)
    func getValue<T: Decodable>(for key: String) throws -> T
}

enum StorageError: Error {
    case keyDoesNotExist
    case unableToConvertStoredValueToDesiredType
}
