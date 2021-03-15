//
//  LoginEntityTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 15/03/21.
//

import XCTest
@testable import TongoNews

final class LoginEntityTests: XCTestCase {
    
    final class MockLoginViewController: LoginControllerType {
        var email: String?
        var password: String?
        
        var getEmailWasCalled = false
        var getPasswordWasCalled = false
        
        func getEmail() -> String? {
            getEmailWasCalled = true
            return email
        }
        
        func getPassword() -> String? {
            getPasswordWasCalled = true
            return password
        }
    }
    
    var mockViewController: MockLoginViewController!
    var sut: LoginEntityType!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = MockLoginViewController()
        sut = LoginEntity()
        sut.setViewController(mockViewController)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_WhenInit_ThenViewControllerShouldBeNil() {
        let sut = LoginEntity()
        XCTAssertNil(sut.viewController)
    }
    
    func test_WhenSetViewController_ThenViewControllerShouldBeChanged() {
        let mockViewController = MockLoginViewController()
        sut.setViewController(mockViewController)
        let sutImplementation = sut as! LoginEntity
        XCTAssertTrue(sutImplementation.viewController === mockViewController)
    }
    
    func test_WhenOnLoginButtonPressedIsInvoked_ThenGetEmailFromViewController() {
        sut.onLoginButtonPressed()
        
        XCTAssertTrue(mockViewController.getEmailWasCalled)
    }
    
    func test_WhenOnLoginButtonPressedIsInvoked_ThenGetPasswordFromViewController() {
        sut.onLoginButtonPressed()
        
        XCTAssertTrue(mockViewController.getPasswordWasCalled)
    }
}
