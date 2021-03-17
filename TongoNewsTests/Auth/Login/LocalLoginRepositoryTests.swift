//
//  LocalLoginRepositoryTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 17/03/21.
//

import XCTest
@testable import TongoNews

final class LocalLoginRepositoryTests: XCTestCase {
    var sut: LoginRepositoryType!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LocalLoginRepository()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_WhenLoginWithValidCredentials_CallOnSuccessClosure() {
        let correctExpectation = XCTestExpectation(description: "onSuccess closure should be called")
        let failureExpectation = XCTestExpectation(description: "onError closure should be called")
        failureExpectation.isInverted = true
        sut.login(with: LoginRepositoryType.Credentials(email: "test@test.com", password: "Password1"), onSuccess: { _ in
            correctExpectation.fulfill()
        }, onError: { _ in
            failureExpectation.fulfill()
        })
        wait(for: [correctExpectation, failureExpectation], timeout: 0.1)
    }
    
    func test_WhenLoginWithInvalidCredentials_CallOnErrorClosure() {
        let correctExpectation = XCTestExpectation(description: "onError closure should be called")
        let failureExpectation = XCTestExpectation(description: "onSuccess closure should be called")
        failureExpectation.isInverted = true
        sut.login(with: LoginRepositoryType.Credentials(email: "invalid@test.com", password: "Password1"), onSuccess: { _ in
            failureExpectation.fulfill()
        }, onError: { _ in
            correctExpectation.fulfill()
        })
        wait(for: [correctExpectation, failureExpectation], timeout: 0.1)
    }
}
