//
//  LoginViewControllerTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import XCTest
@testable import TongoNews

class LoginViewControllerTests: XCTestCase {
    
    final class FakeLoginView: UIView, LoginViewType {
        weak var delegate: LoginViewDelegate?
        func setDelegate(_ delegate: LoginViewDelegate) {
            self.delegate = delegate
        }
        func configureSubviews() {}
    }
    
    final class FakeLoginEntity: LoginEntityType {
        
        weak var viewController: LoginControllerType!
        var onLoginButtonPressedInvoked = false
        
        func onLoginButtonPressed() {
            onLoginButtonPressedInvoked = true
        }
        
        func setViewController(_ viewController: LoginControllerType) {
            self.viewController = viewController
        }
    }
    
    var fakeEntity: FakeLoginEntity!
    var sut: LoginControllerType!

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
}
