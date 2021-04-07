//
//  CredentialsSecureRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 5/04/21.
//

import Foundation

typealias CredentialsSecureStorable = EmailStorable & PasswordStorable & TokenStorable

class CredentialsSecureRepository: CredentialsSecureStorable {
    
    private var emailHelper: EmailStorable
    private var passwordHelper: PasswordStorable
    private var tokenHelper: TokenStorable
    
    convenience init(systemConfig: SystemConfig) {
        let storageManager: StorageManageable
        switch systemConfig {
        case .dev, .test:
            storageManager = DevStorageManager()
        case .prod:
            storageManager = ProdSecureStorageManager(systemConfig: .prod)
        }
        
        self.init(storageManager: storageManager)
    }
    
    init(storageManager: StorageManageable) {
        emailHelper = RepositoryHelperCredentialEmail(storageManager: storageManager)
        passwordHelper = RepositoryHelperCredentialPassword(storageManager: storageManager)
        tokenHelper = RepositoryHelperCredentialToken(storageManager: storageManager)
    }
    
    func store(email: String) {
        emailHelper.store(email: email)
    }
    
    func store(password: String) {
        passwordHelper.store(password: password)
    }
    
    func store(token: String) {
        tokenHelper.store(token: token)
    }
    
    func getEmail() throws -> String {
        return try emailHelper.getEmail()
    }
    
    func getPassword() throws -> String {
        return try passwordHelper.getPassword()
    }
    
    func getToken() throws -> String {
        return try tokenHelper.getToken()
    }
    
    func removeEmail() {
        emailHelper.removeEmail()
    }
    
    func removePassword() {
        passwordHelper.removePassword()
    }
    
    func removeToken() {
        tokenHelper.removeToken()
    }
}
