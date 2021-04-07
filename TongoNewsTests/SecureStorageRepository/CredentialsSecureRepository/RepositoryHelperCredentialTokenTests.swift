//
//  RepositoryHelperCredentialTokenTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 7/04/21.
//

import XCTest
@testable import TongoNews

class RepositoryHelperCredentialTokenTests: XCTestCase {
    
    private var sut: RepositoryHelperCredentialToken!
    private var storageManager: FakeStorageManageable!

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageManager = FakeStorageManageable()
        sut = RepositoryHelperCredentialToken(storageManager: storageManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        storageManager = nil
        try super.tearDownWithError()
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
    
    // MARK: - removeToken
    
    func test_WhenRemoveToken_REmoveTokenInManager() {
        let expectedToken = "dummy-string"
        storageManager.value = expectedToken
        
        sut.removeToken()
        
        XCTAssertNil(storageManager.value)
    }
}
