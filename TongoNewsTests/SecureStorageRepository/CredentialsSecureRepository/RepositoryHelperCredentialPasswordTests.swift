//
//  RepositoryHelperCredentialPasswordTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 7/04/21.
//

import XCTest
@testable import TongoNews

class RepositoryHelperCredentialPasswordTests: XCTestCase {
    
    private var sut: RepositoryHelperCredentialPassword!
    private var storageManager: FakeStorageManageable!

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageManager = FakeStorageManageable()
        sut = RepositoryHelperCredentialPassword(storageManager: storageManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        storageManager = nil
        try super.tearDownWithError()
    }

    // MARK: - storePassword
    
    func test_WhenStorePassword_SavePasswordInManager() {
        let expectedPassword = "dummy-string"
        sut.store(password: expectedPassword)
        XCTAssertEqual(storageManager.value as! String, expectedPassword)
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

    // MARK: - removePassword
    
    func test_WhenRemovePassword_REmovePasswordInManager() {
        let expectedPassword = "dummy-string"
        storageManager.value = expectedPassword

        sut.removePassword()
        
        XCTAssertNil(storageManager.value)
    }
}
