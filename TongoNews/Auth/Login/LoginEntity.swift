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

final class LoginEntity: LoginEntityType {
    weak var viewController: LoginControllerType!
    
    func setViewController(_ viewController: LoginControllerType) {
        self.viewController = viewController
    }
    
    func onLoginButtonPressed() {
        assert(viewController != nil)
        
        let email = viewController.getEmail()
        let password = viewController.getPassword()
        
    }
}
