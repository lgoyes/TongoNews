//
//  LoginViewControllerTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import XCTest
@testable import TongoNews

class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginControllerType!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
