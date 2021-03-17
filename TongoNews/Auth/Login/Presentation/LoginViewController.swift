//
//  LoginViewController.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit

protocol LoginControllerType: AnyObject {
    func getEmail() -> String?
    func getPassword() -> String?
    func showEmailError()
    func hideEmailError()
    func showPasswordError()
    func hidePasswordError()
}

class LoginViewController: UIViewController, LoginControllerType {

    let viewType: ViewType.Type
    let entity: LoginEntityType
    
    init(entity: LoginEntityType, viewType: ViewType.Type = LoginView.self) {
        self.viewType = viewType
        self.entity = entity
        super.init(nibName: nil, bundle: nil)
        self.entity.setViewController(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This method should not be called")
    }
    
    override func loadView() {
        self.view = viewType.getInstance()
        (self.view as? LoginViewType)?.setDelegate(self)
    }
    
    func getEmail() -> String? {
        (self.view as? LoginViewType)?.getEmailFieldText()
    }
    
    func getPassword() -> String? {
        (self.view as? LoginViewType)?.getPasswordFieldText()
    }
    
    func showEmailError() {
        (self.view as? LoginViewType)?.setEmailFieldColor(Theme.Color.TextField.error)
    }
    
    func hideEmailError() {
        (self.view as? LoginViewType)?.setEmailFieldColor(Theme.Color.TextField.defaultColor)
    }
    
    func showPasswordError() {
        (self.view as? LoginViewType)?.setPasswordFieldColor(Theme.Color.TextField.error)
    }
    
    func hidePasswordError() {
        (self.view as? LoginViewType)?.setPasswordFieldColor(Theme.Color.TextField.defaultColor)
    }
}

extension LoginViewController: LoginViewDelegate {
    func onLoginButtonPressed() {
        entity.onLoginButtonPressed()
    }
}
