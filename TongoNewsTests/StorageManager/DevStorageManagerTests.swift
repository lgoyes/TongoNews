//
//  DevStorageManagerTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import XCTest
@testable import TongoNews

class DevStorageManagerTests: XCTestCase {
    
    private var sut: DevStorageManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DevStorageManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - setValue
    
    func test_GivenIntValue_WhenSetValueForKeyIsInvoked_ThenChangeTheValueOfThatKey() {
        let key = "key"
        let expectedValue = 1
        sut.set(value: expectedValue, for: key)
        XCTAssertEqual(sut.entries[key] as! Int, expectedValue)
    }
    
    func test_GivenStringValue_WhenSetValueForKeyIsInvoked_ThenChangeTheValueOfThatKey() {
        let key = "key"
        let expectedValue = "dummy-string"
        sut.set(value: expectedValue, for: key)
        XCTAssertEqual(sut.entries[key] as! String, expectedValue)
    }
    
    func test_GivenBoolValue_WhenSetValueForKeyIsInvoked_ThenChangeTheValueOfThatKey() {
        let key = "key"
        let expectedValue = true
        sut.set(value: expectedValue, for: key)
        XCTAssertEqual(sut.entries[key] as! Bool, expectedValue)
    }
    
    // MARK: - removeValue
    
    func test_WhenRemoveValueIsInvoked_ThenSetNilThatKey() {
        let key = "key"
        sut.entries[key] = "any-value"
        
        sut.removeValue(for: key)
        
        XCTAssertNil(sut.entries[key])
    }
    
    // MARK: - getValue
    
    func test_GivenValueExistsAndIsValidType_WhenGetValueIsInvoked_ReturnValue() {
        let key = "key"
        let value = "any-value"
        sut.entries[key] = value
        
        do {
            let extractedString: String = try sut.getValue(for: key)
            XCTAssertEqual(value, extractedString)
        } catch {
            XCTFail("This point should not be reached")
        }
    }
    
    func test_GivenValueDOESNOTExist_WhenGetValueIsInvoked_ThrowError() {
        let key = "key"
        
        XCTAssertThrowsError(try {
            let _: String = try sut.getValue(for: key)
        }()) { (error) in
            XCTAssertEqual(error as! StorageError, .keyDoesNotExist)
        }
    }
    
    func test_GivenValueExistsButIsNOTValidType_WhenGetValueIsInvoked_ThrowError() {
        let key = "key"
        let value = "any-value"
        sut.entries[key] = value
        
        XCTAssertThrowsError(try {
            let _: Int = try sut.getValue(for: key)
        }()) { (error) in
            XCTAssertEqual(error as! StorageError, .unableToConvertStoredValueToDesiredType)
        }
    }
}
