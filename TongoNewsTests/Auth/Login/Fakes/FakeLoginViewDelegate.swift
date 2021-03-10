//
//  FakeLoginViewDelegate.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 10/03/21.
//

@testable import TongoNews

class FakeLoginViewDelegate: LoginViewDelegate {
    
    var loginButtonPressed = false
    
    func onLoginButtonPressed() {
        loginButtonPressed = true
    }
}
