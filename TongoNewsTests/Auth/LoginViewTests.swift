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
    
    func testWhenInit_ThenInvokeConfigureSubviews() {
        XCTAssertTrue( sut.subviewsAreConfigured )
    }
    
    func test_WhenSetMainContainerIsCalled_ThenAddStackviewAsSubview() {
        let mainStackView = UIStackView()
        sut.setMainContainer(mainStackView)
        let mainStackViewIsSubview = sut.subviews.contains(mainStackView)
        XCTAssertTrue(mainStackViewIsSubview)
    }
    
    func test_WhenSetMainContainerIsCalled_ThenResetTranslatesAutoresizingMaskIntoConstraints() {
        let mainStackView = UIStackView()
        sut.setMainContainer(mainStackView)
        XCTAssertFalse(mainStackView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_WhenConfigureSubViewsIsCalled_ThenSetTheMainStackViewAsSubview() {
        sut.configureSubviews()
        
        let mainStackView = sut.mainStackView
        let mainStackViewIsSubview = sut.subviews.contains(mainStackView)
        XCTAssertTrue(mainStackViewIsSubview)
    }
    
    func test_WhenAddFieldIsCalled_ThenAddFieldToTheMainStackView() {
        let mainStackView = UIStackView()
        
        let textField = UITextField()
        sut.addField(textField, to: mainStackView)
        
        XCTAssertTrue(mainStackView.arrangedSubviews.contains(textField))
    }
    
    func test_WhenConfigureSubViewsIsCalled_ThenSetTheEmailFieldAsTheFirstSubviewInTheStack() {
        sut.configureSubviews()
        
        let mainStackView = sut.mainStackView
        let emailField = sut.emailField
        
        XCTAssertTrue(mainStackView.subviews[0] === emailField)
    }
    
    func test_WhenConfigureSubViewsIsCalled_ThenSetThePasswordFieldAsTheSecondSubviewInTheStack() {
        sut.configureSubviews()
        
        let mainStackView = sut.mainStackView
        let passwordField = sut.passwordField
        
        XCTAssertTrue(mainStackView.subviews[1] === passwordField)
    }
    
    func test_WhenInit_SetPlaceHolderToEmailField() {
        let emailField = sut.emailField
        XCTAssertEqual(emailField.placeholder, LoginView.Constants.email)
    }
    
    func test_WhenInit_SetPlaceHolderToPasswordField() {
        let passwordField = sut.passwordField
        XCTAssertEqual(passwordField.placeholder, LoginView.Constants.password)
    }
}
