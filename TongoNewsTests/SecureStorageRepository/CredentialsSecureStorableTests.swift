//
//  CredentialsSecureStorableTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 2/04/21.
//

import XCTest
@testable import TongoNews

class CredentialsSecureStorableTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
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
