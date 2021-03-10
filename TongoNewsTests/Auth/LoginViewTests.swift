//
//  LoginViewTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit
import XCTest
@testable import TongoNews

class LoginViewTests: XCTestCase {
    var sut: LoginView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_WhenSetMainContainerIsCalled_ThenAddStackviewAsSubview() {
        sut.setMainContainer()
        
        let mainStackView = sut.mainStackView
        let mainStackViewIsSubview = sut.subviews.contains(mainStackView!)
        XCTAssertTrue(mainStackViewIsSubview)
    }
    
    func test_WhenSetMainContainerIsCalled_ThenResetTranslatesAutoresizingMaskIntoConstraints() {
        sut.setMainContainer()
        
        let mainStackView = sut.mainStackView
        XCTAssertFalse(mainStackView!.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_WhenConfigureSubViewsIsCalled_ThenSetTheMainStackViewAsSubview() {
        sut.configureSubviews()
        
        let mainStackView = sut.mainStackView
        let mainStackViewIsSubview = sut.subviews.contains(mainStackView!)
        XCTAssertTrue(mainStackViewIsSubview)
    }
    
    func test_WhenAddViewIsCalled_ThenAddFieldToTheMainStackView() {
        let mainStackView = UIStackView()
        
        let textField = UITextField()
        sut.addView(textField, to: mainStackView)
        
        XCTAssertTrue(mainStackView.arrangedSubviews.contains(textField))
    }
    
    func test_WhenAddViewIsCalled_ThenAddStackViewToTheMainStackView() {
        let mainStackView = UIStackView()
        
        let topStackView = UIStackView()
        sut.addView(topStackView, to: mainStackView)
        
        XCTAssertTrue(mainStackView.arrangedSubviews.contains(topStackView))
    }
    
    func test_WhenConfigureSubViewsIsCalled_ThenSetTheTopContainerStackViewAsTheFirstSubviewInTheStack() {
        sut.configureSubviews()
        
        let mainStackView = sut.mainStackView
        let topStackView = sut.topContainerStackView
        
        XCTAssertTrue(mainStackView!.subviews[0] === topStackView)
    }
    
    func test_WhenConfigureTopContainerStackView_ThenSetTheTopContainerStackViewAsTheFirstSubviewInTheStack() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        let topContainerStack = sut.topContainerStackView
        XCTAssertTrue(mainStackView.subviews[0] === topContainerStack)
    }
    
    func test_WhenConfigureTopContainerStackView_ThenSetTheEmailFieldAsTheFirstSubviewInTheStack() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        let topContainerStack = sut.topContainerStackView
        XCTAssertTrue(topContainerStack!.arrangedSubviews[0] === sut.emailField)
    }
    
    func test_WhenConfigureTopContainerStackView_ThenSetThePasswordFieldAsTheSecondSubviewInTheStack() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        let topContainerStack = sut.topContainerStackView
        XCTAssertTrue(topContainerStack!.arrangedSubviews[1] === sut.passwordField)
    }
    
    func test_GivenConfigureTopContainerWasInvoked_WhenConfigureLoginButton_ThenSetLoginButtonAsTheSecondSubviewInTheMainStack() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        sut.configureLoginButton(in: mainStackView)
        let loginButton = sut.loginButton
        
        XCTAssertTrue(mainStackView.subviews[1] === loginButton)
    }
    
    func test_WhenConfigureSubViewsIsCalled_ThenSetTheLoginButtonAsTheSecondSubviewInTheStack() {
        sut.configureSubviews()
        
        let mainStackView = sut.mainStackView
        let loginButton = sut.loginButton
        
        XCTAssertTrue(mainStackView!.subviews[1] === loginButton)
    }
    
    func test_WhenConfigureEmailField_ThenSetEmailFieldAsTheFirstSubviewInTheTopStack() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        let emailField = sut.emailField!
        XCTAssertTrue(topStackView.subviews[0] === emailField)
    }
    
    func test_WhenConfigureEmailField_SetPlaceHolderToEmailField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        let emailField = sut.emailField!
        XCTAssertEqual(emailField.placeholder, LoginView.Constants.emailPlaceholder)
    }
    
    func test_WhenConfigureEmailField_SetGrayBackgroundToEmailField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        let emailField = sut.emailField!
        XCTAssertEqual(emailField.backgroundColor?.accessibilityName, Theme.Color.textFieldBackground.accessibilityName)
    }
    
    func test_GivenConfigureEmailFieldWasInvoked_WhenConfigurePasswordField_SetPlaceHolderToPasswordField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        
        sut.configurePasswordField(in: topStackView)
        let passwordField = sut.passwordField!
        XCTAssertEqual(passwordField.placeholder, LoginView.Constants.passwordPlaceholder)
    }
    
    func test_GivenConfigureEmailFieldWasInvoked_WhenConfigurePasswordField_SetGrayBackgroundToPasswordField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        
        sut.configurePasswordField(in: topStackView)
        let passwordField = sut.passwordField!
        XCTAssertEqual(passwordField.backgroundColor?.accessibilityName, Theme.Color.textFieldBackground.accessibilityName)
    }
    
    func test_WhenGetInstanceIsCalled_ThenShouldReturnALoginViewInstance() {
        let sut = LoginView.getInstance()
        XCTAssertNotNil(sut)
    }
    
    func test_WhenGetInstanceIsCalled_ThenShouldInvokeConfigureSubviews() {
        let sut = SeamLoginView.getInstance() as! SeamLoginView
        XCTAssertTrue(sut.configureSubviewsWasCalled)
    }
}
