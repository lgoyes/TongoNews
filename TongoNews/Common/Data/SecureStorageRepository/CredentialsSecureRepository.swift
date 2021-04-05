//
//  CredentialsSecureRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 5/04/21.
//

import Foundation

protocol CredentialsSecureStorable {
    func store(email: String)
    func store(password: String)
    func store(token: String)
    func getEmail() throws -> String
    func getPassword() throws -> String
    func getToken() throws -> String
    func removeEmail()
    func removePassword()
    func removeToken()
}

class CredentialsSecureRepository: CredentialsSecureStorable {
    private enum Key: String {
        case email
        case password
        case token
    }
    
    private var storageManager: StorageManageable
    init(storageManager: StorageManageable) {
        self.storageManager = storageManager
    }
    
    func store(email: String) {
        storageManager.set(value: email, for: Key.email.rawValue)
    }
    
    func store(password: String) {
        storageManager.set(value: password, for: Key.password.rawValue)
    }
    
    func store(token: String) {
        storageManager.set(value: token, for: Key.token.rawValue)
    }
    
    func getEmail() throws -> String {
        return try storageManager.getValue(for: Key.email.rawValue)
    }
    
    func getPassword() throws -> String {
        return try storageManager.getValue(for: Key.password.rawValue)
    }
    
    func getToken() throws -> String {
        return try storageManager.getValue(for: Key.token.rawValue)
    }
    
    func removeEmail() {
        storageManager.removeValue(for: Key.email.rawValue)
    }
    
    func removePassword() {
        storageManager.removeValue(for: Key.password.rawValue)
    }
    
    func removeToken() {
        storageManager.removeValue(for: Key.token.rawValue)
    }
}
