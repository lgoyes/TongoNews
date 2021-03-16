//
//  LoginView.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit

protocol LoginViewType: ViewType {
    func setDelegate(_ delegate: LoginViewDelegate)
    func getEmailFieldText() -> String?
    func getPasswordFieldText() -> String?
    func setEmailFieldColor(_ themeColor: UIColor?)
    func setPasswordFieldColor(_ themeColor: UIColor?)
}

protocol LoginViewDelegate: AnyObject {
    func onLoginButtonPressed()
}

class LoginView: UIView, LoginViewType {
    
    struct Constant {
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
        static let loginButtonTitle = "Login"
        struct Margin {
            struct MainContainer {
                static let top = 20.0
                static let bottom = -20.0
                static let leading = 15.0
                static let trailing = -15.0
            }
        }
        static let topContainerSpacing = 15
    }
    
    var mainStackView: UIStackView!
    var topContainerStackView: UIStackView!
    var emailField: UITextField!
    var passwordField: UITextField!
    var loginButton: UIButton!
    
    weak var delegate: LoginViewDelegate?
    
    func setDelegate(_ delegate: LoginViewDelegate) {
        self.delegate = delegate
    }
    
    func configureSubviews() {
        setMainContainer()
        configureTopContainerStackView(in: mainStackView)
        configureLoginButton(in: mainStackView)
    }
    
    func getEmailFieldText() -> String? {
        return emailField.text
    }
    
    func getPasswordFieldText() -> String? {
        return passwordField.text
    }
    
    func setEmailFieldColor(_ themeColor: UIColor?) {
        emailField.backgroundColor = themeColor
    }
    
    func setPasswordFieldColor(_ themeColor: UIColor?) {
        passwordField.backgroundColor = themeColor
    }
    
    func setMainContainer() {
        self.mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing

        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: CGFloat(Constant.Margin.MainContainer.top)),
            mainStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: CGFloat(Constant.Margin.MainContainer.bottom)),
            mainStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: CGFloat(Constant.Margin.MainContainer.leading)),
            mainStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: CGFloat(Constant.Margin.MainContainer.trailing)),
        ])
    }
    
    func configureTopContainerStackView(in mainStack: UIStackView) {
        assert(mainStack.arrangedSubviews.count == 0)
        
        self.topContainerStackView = UIStackView()
        topContainerStackView.axis = .vertical
        topContainerStackView.spacing = CGFloat(Constant.topContainerSpacing)
        
        addView(topContainerStackView, to: mainStack)
        configureEmailField(in: topContainerStackView)
        configurePasswordField(in: topContainerStackView)
    }
    
    func configureLoginButton(in mainStack: UIStackView) {
        assert(mainStack.arrangedSubviews.count == 1)
        
        self.loginButton = UIButton()
        loginButton.setTitle(Constant.loginButtonTitle, for: .normal)
        loginButton.backgroundColor = Theme.Color.active
        loginButton.addTarget(self, action: #selector(onLoginButtonPressed(_:)), for: .touchUpInside)
        
        addView(loginButton, to: mainStack)
    }
    
    func configureEmailField(in topContainerStack: UIStackView) {
        assert(topContainerStack.arrangedSubviews.count == 0)
        
        self.emailField = UITextField()
        emailField.placeholder = Constant.emailPlaceholder
        emailField.backgroundColor = Theme.Color.TextField.defaultColor
        
        addView(emailField, to: topContainerStack)
    }
    
    func configurePasswordField(in topContainerStack: UIStackView) {
        assert(topContainerStack.arrangedSubviews.count == 1)
        
        self.passwordField = UITextField()
        passwordField.placeholder = Constant.passwordPlaceholder
        passwordField.backgroundColor = Theme.Color.TextField.defaultColor
        
        addView(passwordField, to: topContainerStack)
    }
    
    func addView(_ view: UIView, to stackView: UIStackView) {
        stackView.addArrangedSubview(view)
    }
    
    @objc func onLoginButtonPressed(_ sender: UIButton) {
        delegate?.onLoginButtonPressed()
    }
}
