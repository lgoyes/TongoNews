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

final class LoginViewController: UIViewController, LoginControllerType {

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
        fatalError()
    }
    
    func getPassword() -> String? {
        fatalError()
    }
    
    func showEmailError() {
        fatalError()
    }
    
    func hideEmailError() {
        fatalError()
    }
    
    func showPasswordError() {
        fatalError()
    }
    
    func hidePasswordError() {
        fatalError()
    }
}

extension LoginViewController: LoginViewDelegate {
    func onLoginButtonPressed() {
        entity.onLoginButtonPressed()
    }
}
