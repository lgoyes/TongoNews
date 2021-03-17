//
//  LoginViewControllerTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import XCTest
@testable import TongoNews

final class LoginViewControllerTests: XCTestCase {
    
    private var fakeEntity: FakeLoginEntity!
    private var sut: LoginControllerType!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeEntity = FakeLoginEntity()
        sut = LoginViewController(entity: fakeEntity, viewType: FakeLoginView.self)
    }

    override func tearDownWithError() throws {
        sut = nil
        fakeEntity = nil
        try super.tearDownWithError()
    }
    
    func test_WhenInit_ThenViewIfLoadedShouldBeNil() {
        let sutImplementation = sut as! LoginViewController
        XCTAssertNil(sutImplementation.viewIfLoaded)
    }
    
    func test_WhenViewIsRequested_ThenLoadViewShouldRunAndALoginViewTypeShouldBeReturned() {
        let sutImplementation = sut as! LoginViewController
        XCTAssertTrue( sutImplementation.view is LoginViewType )
    }
    
    func test_WhenLoadViewRuns_ThenItShouldSetTheViewsDelegateAsSelf() {
        let sutImplementation = (sut as! LoginViewController)
        sutImplementation.loadViewIfNeeded()
        
        let view = sutImplementation.view as! FakeLoginView
        XCTAssertTrue(view.delegate === sutImplementation)
    }
    
    func test_WhenInit_ThenEntityShouldBeSet() {
        let sutImplementation = sut as! LoginViewController
        XCTAssertNotNil(sutImplementation.entity)
    }
    
    func test_WhenOnLoginButtonPressedIsInvoked_ThenItShouldInformOnTheEventToItsEntity() {
        (sut as! LoginViewDelegate).onLoginButtonPressed()
        XCTAssertTrue(fakeEntity.onLoginButtonPressedInvoked)
    }
    
    func test_WhenGetEmailIsCalled_ThenRequestViewsEmailFieldText() {
        let fakeView = FakeLoginView()
        let sutImplementation = sut as! LoginViewController
        sutImplementation.view = fakeView
        
        let _ = sutImplementation.getEmail()
        
        XCTAssertTrue(fakeView.getEmailFieldTextWasCalled)
    }
    
    func test_WhenGetPasswordIsCalled_ThenRequestViewsPasswordFieldText() {
        let fakeView = FakeLoginView()
        let sutImplementation = sut as! LoginViewController
        sutImplementation.view = fakeView
        
        let _ = sutImplementation.getPassword()
        
        XCTAssertTrue(fakeView.getPasswordFieldTextWasCalled)
    }
    
    func test_WhenShowEmailError_ThenSetErrorColorToEmailField() {
        let fakeView = FakeLoginView()
        (sut as! LoginViewController).view = fakeView
        
        sut.showEmailError()
        
        XCTAssertEqual(fakeView.emailFieldBackgroundColor?.accessibilityName, Theme.Color.TextField.error.accessibilityName)
    }
    
    func test_WhenHideEmailError_ThenSetNilColorToEmailField() {
        let fakeView = FakeLoginView()
        (sut as! LoginViewController).view = fakeView
        
        sut.hideEmailError()
        
        XCTAssertEqual(fakeView.emailFieldBackgroundColor?.accessibilityName, Theme.Color.TextField.defaultColor.accessibilityName)
    }
    
    func test_WhenShowPasswordError_ThenSetErrorColorToPasswordField() {
        let fakeView = FakeLoginView()
        (sut as! LoginViewController).view = fakeView
        
        sut.showPasswordError()
        
        XCTAssertEqual(fakeView.passwordFieldBackgroundColor?.accessibilityName, Theme.Color.TextField.error.accessibilityName)
    }
    
    func test_WhenHidePasswordError_ThenSetNilColorToPasswordField() {
        let fakeView = FakeLoginView()
        (sut as! LoginViewController).view = fakeView
        
        sut.hidePasswordError()
        
        XCTAssertEqual(fakeView.passwordFieldBackgroundColor?.accessibilityName, Theme.Color.TextField.defaultColor.accessibilityName)
    }
}

fileprivate final class FakeLoginView: UIView, LoginViewType {
    
    weak var delegate: LoginViewDelegate?
    var emailFieldText: String?
    var passwordFieldText: String?
    var emailFieldBackgroundColor: UIColor?
    var passwordFieldBackgroundColor: UIColor?
    var getEmailFieldTextWasCalled = false
    var getPasswordFieldTextWasCalled = false
    
    func setDelegate(_ delegate: LoginViewDelegate) {
        self.delegate = delegate
    }
    func configureSubviews() {}
    func getEmailFieldText() -> String? {
        getEmailFieldTextWasCalled = true
        return emailFieldText
    }
    
    func getPasswordFieldText() -> String? {
        getPasswordFieldTextWasCalled = true
        return passwordFieldText
    }
    
    func setEmailFieldColor(_ themeColor: UIColor?) {
        emailFieldBackgroundColor = themeColor
    }
    
    func setPasswordFieldColor(_ themeColor: UIColor?) {
        passwordFieldBackgroundColor = themeColor
    }
}

fileprivate final class FakeLoginEntity: LoginEntityType {
    
    weak var viewController: LoginControllerType!
    var onLoginButtonPressedInvoked = false
    
    func onLoginButtonPressed() {
        onLoginButtonPressedInvoked = true
    }
    
    func setViewController(_ viewController: LoginControllerType) {
        self.viewController = viewController
    }
}
