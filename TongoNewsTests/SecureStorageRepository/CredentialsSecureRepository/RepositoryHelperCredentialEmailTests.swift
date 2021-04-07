//
//  RepositoryHelperCredentialEmailTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 7/04/21.
//

import XCTest
@testable import TongoNews

class RepositoryHelperCredentialEmailTests: XCTestCase {
    
    private var sut: RepositoryHelperCredentialEmail!
    private var storageManager: FakeStorageManageable!

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageManager = FakeStorageManageable()
        sut = RepositoryHelperCredentialEmail(storageManager: storageManager)
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

    // MARK: - removeEmail
    
    func test_WhenRemoveEmail_REmoveEmailInManager() {
        let expectedEmail = "dummy-string"
        storageManager.value = expectedEmail
        
        sut.removeEmail()
        
        XCTAssertNil(storageManager.value)
    }
}
