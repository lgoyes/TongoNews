//
//  LoginViewTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit
import XCTest
@testable import TongoNews

final class LoginViewTests: XCTestCase {
    
    private var sut: LoginView!
    
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
    
    func test_WhenSetMainContainerIsCalled_ThenCreateAVerticalStack() {
        sut.setMainContainer()
        
        let mainStackView = sut.mainStackView!
        XCTAssertEqual(mainStackView.axis, .vertical)
    }
    
    func test_WhenSetMainContainerIsCalled_ThenSetDistributionToEquallySpaced() {
        sut.setMainContainer()
        
        let mainStackView = sut.mainStackView!
        XCTAssertEqual(mainStackView.distribution, .equalSpacing)
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
    
    func test_WhenConfigureTopContainerStackView_CreateAVerticalStackAsTheTopContainer() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        let topContainerStack = sut.topContainerStackView!
        XCTAssertEqual(topContainerStack.axis, .vertical)
    }
    
    func test_WhenConfigureTopContainerStackView_AddSomeSpacingToTheTopContainer() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        let topContainerStack = sut.topContainerStackView!
        XCTAssertEqual(topContainerStack.spacing, CGFloat(LoginView.Constant.topContainerSpacing))
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
        XCTAssertEqual(emailField.placeholder, LoginView.Constant.emailPlaceholder)
    }
    
    func test_WhenConfigureEmailField_SetGrayBackgroundToEmailField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        let emailField = sut.emailField!
        XCTAssertEqual(emailField.backgroundColor?.accessibilityName, Theme.Color.TextField.defaultColor.accessibilityName)
    }
    
    func test_GivenConfigureEmailFieldWasInvoked_WhenConfigurePasswordField_SetPlaceHolderToPasswordField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        
        sut.configurePasswordField(in: topStackView)
        let passwordField = sut.passwordField!
        XCTAssertEqual(passwordField.placeholder, LoginView.Constant.passwordPlaceholder)
    }
    
    func test_GivenConfigureEmailFieldWasInvoked_WhenConfigurePasswordField_SetGrayBackgroundToPasswordField() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        
        sut.configurePasswordField(in: topStackView)
        let passwordField = sut.passwordField!
        XCTAssertEqual(passwordField.backgroundColor?.accessibilityName, Theme.Color.TextField.defaultColor.accessibilityName)
    }
    
    func test_GivenConfigureEmailFieldWasInvoked_WhenConfigurePasswordField_ThenMakePasswordASecureTextEntry() {
        let topStackView = UIStackView()
        sut.configureEmailField(in: topStackView)
        
        sut.configurePasswordField(in: topStackView)
        let passwordField = sut.passwordField!
        XCTAssertTrue(passwordField.isSecureTextEntry)
    }
    
    func test_WhenGetInstanceIsCalled_ThenShouldReturnALoginViewInstance() {
        let sut = LoginView.getInstance()
        XCTAssertNotNil(sut)
    }
    
    func test_WhenGetInstanceIsCalled_ThenShouldInvokeConfigureSubviews() {
        let sut = SeamLoginView.getInstance() as! SeamLoginView
        XCTAssertTrue(sut.configureSubviewsWasCalled)
    }
    
    func test_GivenConfigureTopContainerWasInvoked_WhenConfigureLoginButtonIsCalled_ThenSetTitleToLogin() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        sut.configureLoginButton(in: mainStackView)
        
        let loginButton = sut.loginButton!
        
        XCTAssertEqual(loginButton.currentTitle, LoginView.Constant.loginButtonTitle)
    }
    
    func test_GivenConfigureTopContainerWasInvoked_WhenConfigureLoginButtonIsCalled_ThenSetActiveColorToBackgrounColor() {
        let mainStackView = UIStackView()
        sut.configureTopContainerStackView(in: mainStackView)
        
        sut.configureLoginButton(in: mainStackView)
        
        let loginButton = sut.loginButton!
        
        XCTAssertEqual(loginButton.backgroundColor?.accessibilityName, Theme.Color.active.accessibilityName)
    }
    
    func test_WhenSetDelegateIsCalled_ThenSetDelegate() {
        let sut = SeamLoginView.getInstance() as! SeamLoginView
        let fakeDelegate = FakeLoginViewDelegate()
        sut.setDelegate(fakeDelegate)
        
        XCTAssertTrue(sut.delegate === fakeDelegate)
    }
    
    func test_GivenSubviewsAreConfiguredAndDelegateIsSet_WhenLoginButtonIsTapped_ThenInformOnDelegateAboutAction() {
        sut.configureSubviews()
        let fakeDelegate = FakeLoginViewDelegate()
        sut.setDelegate(fakeDelegate)
        
        sut.loginButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(fakeDelegate.loginButtonPressed)
    }
    
    func test_GivenSubviewsAreConfigured_WhenSetEmailFieldColor_SetBackgroundColorToEmailField() {
        sut.configureSubviews()
        sut.setEmailFieldColor(nil)
        
        let expectedColor = UIColor.white
        sut.setEmailFieldColor(expectedColor)
        
        XCTAssertEqual(sut.emailField.backgroundColor?.accessibilityName, expectedColor.accessibilityName)
    }
    
    func test_GivenSubviewsAreConfigured_WhenSetPasswordFieldColor_SetBackgroundColorToPasswordField() {
        sut.configureSubviews()
        sut.setPasswordFieldColor(nil)
        
        let expectedColor = UIColor.white
        sut.setPasswordFieldColor(expectedColor)
        
        XCTAssertEqual(sut.passwordField.backgroundColor?.accessibilityName, expectedColor.accessibilityName)
    }
}

fileprivate final class SeamLoginView: LoginView {
    
    var configureSubviewsWasCalled = false
    
    override func configureSubviews() {
        super.configureSubviews()
        configureSubviewsWasCalled = true
    }
}

fileprivate final class FakeLoginViewDelegate: LoginViewDelegate {
    
    var loginButtonPressed = false
    
    func onLoginButtonPressed() {
        loginButtonPressed = true
    }
}
