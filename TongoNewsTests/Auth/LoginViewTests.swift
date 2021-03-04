//
//  LoginViewTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 3/03/21.
//

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
    
    func testWhenInit_ThenSetBackgroundColorToRed() {
        XCTAssertTrue( sut.backgroundColor == .red )
    }
}
