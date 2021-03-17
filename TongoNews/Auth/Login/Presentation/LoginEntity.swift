//
//  LoginEntity.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 15/03/21.
//

import Foundation

protocol LoginEntityType {
    func setViewController(_ viewController: LoginControllerType)
    func onLoginButtonPressed()
}

class LoginEntity: LoginEntityType {
    
    weak var viewController: LoginControllerType!
    
    func setViewController(_ viewController: LoginControllerType) {
        self.viewController = viewController
    }
    
    func onLoginButtonPressed() {
        let _ = validateForm()
    }
    
    func validateForm() -> Bool {
        let emailValid = validateEmailField()
        if (emailValid) {
            viewController.hideEmailError()
        } else {
            viewController.showEmailError()
        }
        
        let passwordValid = validatePasswordField()
        if (passwordValid) {
            viewController.hidePasswordError()
        } else {
            viewController.showPasswordError()
        }
        
        return emailValid && passwordValid
    }
    
    func performLogin() {
        
    }
    
    func validateEmailField() -> Bool {
        assert(viewController != nil)
        
        guard let email = viewController.getEmail() else {
            return false
        }
        
        return Regex.Predicate.email.evaluate(with: email)
    }
    
    func validatePasswordField() -> Bool {
        assert(viewController != nil)
        
        guard let password = viewController.getPassword() else {
            return false
        }
        
        return Regex.Predicate.password.evaluate(with: password)
    }
}
