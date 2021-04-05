//
//  CredentialsSecureRepositoryTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import XCTest
@testable import TongoNews

class CredentialsSecureRepositoryTests: XCTestCase {
    
    private var sut: CredentialsSecureRepository!
    private var storageManager: FakeStorageManageable!

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageManager = FakeStorageManageable()
        sut = CredentialsSecureRepository(storageManager: storageManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        storageManager = nil
        try super.tearDownWithError()
    }
    
    // MARK: - storeEmail
    
    func test_WhenStoreEmail_SaveEmailInManager() {
        let expectedEmail = "dummy-string"
        sut.store(email: expectedEmail)
        XCTAssertEqual(storageManager.value as! String, expectedEmail)
    }
    
    // MARK: - storePassword
    
    func test_WhenStorePassword_SavePasswordInManager() {
        let expectedPassword = "dummy-string"
        sut.store(password: expectedPassword)
        XCTAssertEqual(storageManager.value as! String, expectedPassword)
    }
    
    // MARK: - storeToken
    
    func test_WhenStoreToken_SaveTokenInManager() {
        let expectedToken = "dummy-string"
        sut.store(token: expectedToken)
        XCTAssertEqual(storageManager.value as! String, expectedToken)
    }
    
    // MARK: - getToken
    
    func test_GivenValueInManager_WhenGetToken_DoNotThrowError() {
        let expectedToken = "dummy-string"
        storageManager.value = expectedToken
        
        XCTAssertNoThrow(try sut.getToken())
    }
    
    func test_GivenNOValueInManager_WhenGetToken_ThrowError() {
        XCTAssertThrowsError(try sut.getToken())
    }
    
    func test_GivenValueInManager_WhenGetToken_ReturnValue() {
        let expectedToken = "dummy-string"
        storageManager.value = expectedToken
        
        let actualToken = try! sut.getToken()
        
        XCTAssertEqual(actualToken, expectedToken)
    }
    
    // MARK: - getEmail
    
    func test_GivenValueInManager_WhenGetEmail_DoNotThrowError() {
        let expectedEmail = "dummy-string"
        storageManager.value = expectedEmail
        
        XCTAssertNoThrow(try sut.getEmail())
    }
    
    func test_GivenNOValueInManager_WhenGetEmail_ThrowError() {
        XCTAssertThrowsError(try sut.getEmail())
    }
    
    func test_GivenValueInManager_WhenGetEmail_ReturnValue() {
        let expectedEmail = "dummy-string"
        storageManager.value = expectedEmail
        
        let actualEmail = try! sut.getEmail()
        
        XCTAssertEqual(actualEmail, expectedEmail)
    }
    
    // MARK: - getPassword
    
    func test_GivenValueInManager_WhenGetPassword_DoNotThrowError() {
        let expectedPassword = "dummy-string"
        storageManager.value = expectedPassword
        
        XCTAssertNoThrow(try sut.getPassword())
    }
    
    func test_GivenNOValueInManager_WhenGetPassword_ThrowError() {
        XCTAssertThrowsError(try sut.getPassword())
    }
    
    func test_GivenValueInManager_WhenGetPassword_ReturnValue() {
        let expectedPassword = "dummy-string"
        storageManager.value = expectedPassword
        
        let actualPassword = try! sut.getPassword()
        
        XCTAssertEqual(actualPassword, expectedPassword)
    }
    
    // MARK: - removeEmail
    
    func test_WhenRemoveEmail_REmoveEmailInManager() {
        let expectedEmail = "dummy-string"
        storageManager.value = expectedEmail
        
        sut.removeEmail()
        
        XCTAssertNil(storageManager.value)
    }
    
    // MARK: - removePassword
    
    func test_WhenRemovePassword_REmovePasswordInManager() {
        let expectedPassword = "dummy-string"
        storageManager.value = expectedPassword

        sut.removePassword()
        
        XCTAssertNil(storageManager.value)
    }
    
    // MARK: - removeToken
    
    func test_WhenRemoveToken_REmoveTokenInManager() {
        let expectedToken = "dummy-string"
        storageManager.value = expectedToken
        
        sut.removeToken()
        
        XCTAssertNil(storageManager.value)
    }
}
