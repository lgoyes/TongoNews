//
//  RepositoryHelperCredentialPassword.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 7/04/21.
//

import Foundation

protocol PasswordStorable {
    func store(password: String)
    func getPassword() throws -> String
    func removePassword()
}

class RepositoryHelperCredentialPassword: PasswordStorable {
    private let key = "password"
    
    private var storageManager: StorageManageable
    init(storageManager: StorageManageable) {
        self.storageManager = storageManager
    }
    
    func store(password: String) {
        storageManager.set(value: password, for: key)
    }
    
    func getPassword() throws -> String {
        return try storageManager.getValue(for: key)
    }
    
    func removePassword() {
        storageManager.removeValue(for: key)
    }
}
