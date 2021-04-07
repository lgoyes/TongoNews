//
//  RepositoryHelperCredentialToken.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 7/04/21.
//

import Foundation

protocol TokenStorable {
    func store(token: String)
    func getToken() throws -> String
    func removeToken()
}

class RepositoryHelperCredentialToken: TokenStorable {
    private let key = "token"
    
    private var storageManager: StorageManageable
    init(storageManager: StorageManageable) {
        self.storageManager = storageManager
    }
    
    func store(token: String) {
        storageManager.set(value: token, for: key)
    }
    
    func getToken() throws -> String {
        return try storageManager.getValue(for: key)
    }
    
    func removeToken() {
        storageManager.removeValue(for: key)
    }
}
