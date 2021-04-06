//
//  ProdSecureStorageManagerTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 6/04/21.
//

import XCTest
import KeychainAccess
@testable import TongoNews

class ProdSecureStorageManagerTests: XCTestCase {

    private var sut: ProdSecureStorageManager!
    private var keychain: Keychain!
    private var jsonDecoder: JSONDecoder!
    private var jsonEncoder: JSONEncoder!
    let testKey = "key"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProdSecureStorageManager(systemConfig: .test)
        keychain = sut.getKeychain()
        jsonDecoder = JSONDecoderManager.jsonDecoder
        jsonEncoder = JSONEncoderManager.jsonEncoder
    }

    override func tearDownWithError() throws {
        jsonDecoder = nil
        jsonEncoder = nil
        keychain[data: testKey] = nil
        keychain = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - setValue
    
    func test_GivenIntValue_WhenSetValueForKeyIsInvoked_ThenChangeTheValueOfThatKey() {
        let expectedValue = 1
        sut.set(value: expectedValue, for: testKey)
        
        let storedValue = keychain[data: testKey]!
        let convertedValue = try! jsonDecoder.decode(Int.self, from: storedValue)
        
        XCTAssertEqual(convertedValue, expectedValue)
    }
    
    func test_GivenStringValue_WhenSetValueForKeyIsInvoked_ThenChangeTheValueOfThatKey() {
        let expectedValue = "dummy-string"
        sut.set(value: expectedValue, for: testKey)
        
        let storedValue = keychain[data: testKey]!
        let convertedValue = try! jsonDecoder.decode(String.self, from: storedValue)
        
        XCTAssertEqual(convertedValue, expectedValue)
    }

    func test_GivenBoolValue_WhenSetValueForKeyIsInvoked_ThenChangeTheValueOfThatKey() {
        let expectedValue = true
        sut.set(value: expectedValue, for: testKey)
        
        let storedValue = keychain[data: testKey]!
        let convertedValue = try! jsonDecoder.decode(Bool.self, from: storedValue)
        
        XCTAssertEqual(convertedValue, expectedValue)
    }

    // MARK: - removeValue

    func test_WhenRemoveValueIsInvoked_ThenSetNilThatKey() {
        let value = "any-value"
        keychain[data: testKey] = try! jsonEncoder.encode(value)

        sut.removeValue(for: testKey)
        
        let storedValue = keychain[data: testKey]

        XCTAssertNil(storedValue)
    }

    // MARK: - getValue

    func test_GivenValueExistsAndIsAString_WhenGetValueIsInvoked_ReturnValue() {
        let value = "any-value"
        keychain[data: testKey] = try! jsonEncoder.encode(value)

        do {
            let extractedString: String = try sut.getValue(for: testKey)
            XCTAssertEqual(value, extractedString)
        } catch {
            XCTFail("This point should not be reached")
        }
    }

    func test_GivenValueDOESNOTExist_WhenGetValueIsInvoked_ThrowError() {
        XCTAssertThrowsError(try {
            let _: String = try sut.getValue(for: testKey)
        }()) { (error) in
            XCTAssertEqual(error as! StorageError, .keyDoesNotExist)
        }
    }

    func test_GivenValueExistsAndIsAnInteger_WhenGetValueIsInvoked_ReturnIntegerValue() {
        let value = 1
        keychain[data: testKey] = try! jsonEncoder.encode(value)

        do {
            let extractedInt: Int = try sut.getValue(for: testKey)
            XCTAssertEqual(value, extractedInt)
        } catch {
            XCTFail("This point should not be reached")
        }
    }
    
    func test_GivenValueExistsAndIsABool_WhenGetValueIsInvoked_ReturnBoolValue() {
        let value = true
        keychain[data: testKey] = try! jsonEncoder.encode(value)

        do {
            let extractedValue: Bool = try sut.getValue(for: testKey)
            XCTAssertEqual(value, extractedValue)
        } catch {
            XCTFail("This point should not be reached")
        }
    }
    
    func test_GivenValueExistsButIsNOTValidType_WhenGetValueIsInvoked_ThrowError() {
        let value = "any-value"
        keychain[data: testKey] = try! jsonEncoder.encode(value)
        
        XCTAssertThrowsError(try {
            let _: Int = try sut.getValue(for: testKey)
        }()) { (error) in
            XCTAssertEqual(error as! StorageError, .unableToConvertStoredValueToDesiredType)
        }
    }
}
