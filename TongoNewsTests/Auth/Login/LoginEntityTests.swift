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
        var showEmailErrorWasCalled = false
        var hideEmailErrorWasCalled = false
        var showPasswordErrorWasCalled = false
        var hidePasswordErrorWasCalled = false
        
        func getEmail() -> String? {
            getEmailWasCalled = true
            return email
        }
        
        func getPassword() -> String? {
            getPasswordWasCalled = true
            return password
        }
        
        func showEmailError() {
            showEmailErrorWasCalled = true
        }
        
        func hideEmailError() {
            hideEmailErrorWasCalled = true
        }
        
        func showPasswordError() {
            showPasswordErrorWasCalled = true
        }
        
        func hidePasswordError() {
            hidePasswordErrorWasCalled = true
        }
    }
    
    final class SeamLoginEntity: LoginEntity {
        var validateFormWasCalled = false
        
        override func validateForm() -> Bool {
            validateFormWasCalled = true
            return super.validateForm()
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
    
    func test_WhenEmailFieldIsInvoked_ThenGetEmailFromViewController() {
        let sutImplementation = sut as! LoginEntity
        let _ = sutImplementation.validateEmailField()
        XCTAssertTrue(mockViewController.getEmailWasCalled)
    }
    
    func test_GivenTheViewControllerWithAValidEmail_WhenValidateEmailFieldIsInvoked_ThenReturnTrue() {
        mockViewController.email = "test@test.com"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validateEmailField()
        XCTAssertTrue(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedEmail_empty_WhenValidateEmailFieldIsInvoked_ThenReturnFalse() {
        mockViewController.email = ""
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validateEmailField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedEmail_missingServer_WhenValidateEmailFieldIsInvoked_ThenReturnFalse() {
        mockViewController.email = "test@.com"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validateEmailField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedEmail_missingAt_WhenValidateEmailFieldIsInvoked_ThenReturnFalse() {
        mockViewController.email = "testtest.com"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validateEmailField()
        XCTAssertFalse(isValid)
    }

    func test_GivenTheViewControllerWithABadFormattedEmail_missingDomainName_WhenValidateEmailFieldIsInvoked_ThenReturnFalse() {
        mockViewController.email = "test@test"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validateEmailField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedPassword_lessThan8Char_WhenValidatePasswordFieldIsInvoked_ThenReturnFalse() {
        mockViewController.password = "Passwo1"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validatePasswordField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedPassword_missingSpecialChar_WhenValidatePasswordFieldIsInvoked_ThenReturnFalse() {
        mockViewController.password = "Password1"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validatePasswordField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedPassword_missingUppercase_WhenValidatePasswordFieldIsInvoked_ThenReturnFalse() {
        mockViewController.password = "password1*"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validatePasswordField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithABadFormattedPassword_missingLowercase_WhenValidatePasswordFieldIsInvoked_ThenReturnFalse() {
        mockViewController.password = "PASSWORD1*"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validatePasswordField()
        XCTAssertFalse(isValid)
    }
    
    func test_GivenTheViewControllerWithAValidFormattedPassword_WhenValidatePasswordFieldIsInvoked_ThenReturnFalse() {
        mockViewController.password = "Passwo1*"
        
        let sutImplementation = sut as! LoginEntity
        let isValid = sutImplementation.validatePasswordField()
        XCTAssertTrue(isValid)
    }
    
    func test_GivenThatEmailIsValid_WhenValidateFormIsInvoked_ThenCallHideEmailErrorOnViewController() {
        mockViewController.email = "test@test.com"
        
        let sutImplementation = sut as! LoginEntity
        let _ = sutImplementation.validateForm()
        
        XCTAssertTrue(mockViewController.hideEmailErrorWasCalled)
    }
    
    func test_GivenThatEmailIsNOTValid_WhenValidateFormIsInvoked_ThenCallShowEmailErrorOnViewController() {
        mockViewController.email = "test@test"
        
        let sutImplementation = sut as! LoginEntity
        let _ = sutImplementation.validateForm()
        
        XCTAssertTrue(mockViewController.showEmailErrorWasCalled)
    }
    
    func test_GivenThatPasswordIsValid_WhenValidateFormIsInvoked_ThenCallHideEmailErrorOnViewController() {
        mockViewController.password = "Password1*"
        
        let sutImplementation = sut as! LoginEntity
        let _ = sutImplementation.validateForm()
        
        XCTAssertTrue(mockViewController.hidePasswordErrorWasCalled)
    }
    
    func test_GivenThatPasswordIsNOTValid_WhenValidateFormIsInvoked_ThenCallShowEmailErrorOnViewController() {
        mockViewController.password = "Password"
        
        let sutImplementation = sut as! LoginEntity
        let _ = sutImplementation.validateForm()
        
        XCTAssertTrue(mockViewController.showPasswordErrorWasCalled)
    }
    
    func test_WhenOnLoginButtonPressedIsCalled_ThenInvokeValidateForm() {
        let sut = SeamLoginEntity()
        sut.setViewController(mockViewController)
        
        sut.onLoginButtonPressed()
        
        XCTAssertTrue(sut.validateFormWasCalled)
    }
}
