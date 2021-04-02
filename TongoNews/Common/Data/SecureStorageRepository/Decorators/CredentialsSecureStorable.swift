//
//  CredentialsSecureStorable.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/04/21.
//

import Foundation

protocol CredentialsSecureStorable: SecureStorageRepository {
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

class CredentialsSecureStorageRepository: SecureStorageRepositoryDecorator, CredentialsSecureStorable {
    
    private enum Key: String {
        case email
        case password
        case token
    }
    
    func store(email: String) {
        set(value: email, for: Key.email.rawValue)
    }
    
    func store(password: String) {
        set(value: password, for: Key.password.rawValue)
    }
    
    func store(token: String) {
        set(value: token, for: Key.token.rawValue)
    }
    
    func getEmail() throws -> String {
        return try getValue(for: Key.email.rawValue)
    }
    
    func getPassword() throws -> String {
        return try getValue(for: Key.password.rawValue)
    }
    
    func getToken() throws -> String {
        return try getValue(for: Key.token.rawValue)
    }
    
    func removeEmail() {
        removeValue(for: Key.email.rawValue)
    }
    
    func removePassword() {
        removeValue(for: Key.password.rawValue)
    }
    
    func removeToken() {
        removeValue(for: Key.token.rawValue)
    }
}
