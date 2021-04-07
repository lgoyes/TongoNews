//
//  RepositoryHelperCredentialEmail.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 7/04/21.
//

import Foundation

protocol EmailStorable {
    func store(email: String)
    func getEmail() throws -> String
    func removeEmail()
}

class RepositoryHelperCredentialEmail: EmailStorable {
    private let key = "email"
    
    private var storageManager: StorageManageable
    init(storageManager: StorageManageable) {
        self.storageManager = storageManager
    }
    
    func store(email: String) {
        storageManager.set(value: email, for: key)
    }
    
    func getEmail() throws -> String {
        return try storageManager.getValue(for: key)
    }
    
    func removeEmail() {
        storageManager.removeValue(for: key)
    }
}
