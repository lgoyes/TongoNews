//
//  SecureStorageRepositoryDecorator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import Foundation

class SecureStorageRepositoryDecorator: SecureStorageRepository {
    
    var repository: SecureStorageRepository
    init(repository: SecureStorageRepository) {
        self.repository = repository
    }
    
    func set(value: Any, for key: String) {
        repository.set(value: value, for: key)
    }
    
    func removeValue(for key: String) {
        repository.removeValue(for: key)
    }
    
    func getValue<T>(for key: String) throws -> T {
        return try repository.getValue(for: key)
    }
}
