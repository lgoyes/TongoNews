//
//  SecureStorageRepositoryDecoratorTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import XCTest
@testable import TongoNews

class SecureStorageRepositoryDecoratorTests: XCTestCase {
    private var sut: SecureStorageRepositoryDecorator!
    private var repository: FakeRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = FakeRepository()
        sut = SecureStorageRepositoryDecorator(repository: repository)
    }

    override func tearDownWithError() throws {
        sut = nil
        repository = nil
        try super.tearDownWithError()
    }
    
    // MARK: - set
    
    func test_WhenSetIsInvoked_ThenSetValueToRepository() {
        let value = 1
        let key = ""
        sut.set(value: value, for: key)
        XCTAssertEqual(repository.value as! Int, value)
    }
    
    // MARK: - removeValue
    
    func test_WhenRemoveValueIsInvoked_TheSetValueToNil() {
        repository.value = 1
        sut.removeValue(for: "")
        XCTAssertNil(repository.value)
    }
    
    // MARK: - getValue
    
    func test_WhenGetValueIsInvoked_ThenReturnValue() {
        let expectedValue = 1
        repository.value = expectedValue
        let actualValue: Int = try! sut.getValue(for: "")
        XCTAssertEqual(actualValue, expectedValue)
    }
}

fileprivate class FakeRepository: SecureStorageRepository {
    var value: Any?
    
    func set(value: Any, for key: String) {
        self.value = value
    }
    
    func removeValue(for key: String) {
        value = nil
    }
    
    func getValue<T>(for key: String) throws -> T {
        guard let value = self.value else {
            throw SecureStorageRepositoryError.keyDoesNotExist
        }
        guard let castedValue = value as? T else {
            throw SecureStorageRepositoryError.unableToConvertStoredValueToDesiredType
        }
        return castedValue
    }
}
