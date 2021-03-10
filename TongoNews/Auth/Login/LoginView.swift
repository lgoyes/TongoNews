//
//  LoginView.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit

protocol LoginViewType {
    
}

final class LoginView: UIView, LoginViewType {
    
    struct Constants {
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
    }
    
    var mainStackView: UIStackView!
    var topContainerStackView: UIStackView!
    var emailField: UITextField!
    var passwordField: UITextField!
    var loginButton: UIButton!
    
    var subviewsAreConfigured = false
    
    func configureSubviews() {
        setMainContainer()
        configureTopContainerStackView(in: mainStackView)
        configureLoginButton(in: mainStackView)
        subviewsAreConfigured = true
    }
    
    func setMainContainer() {
        self.mainStackView = UIStackView()
        mainStackView.axis = .vertical

        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func configureTopContainerStackView(in mainStack: UIStackView) {
        assert(mainStack.arrangedSubviews.count == 0)
        
        self.topContainerStackView = UIStackView()
        topContainerStackView.axis = .vertical
        
        addView(topContainerStackView, to: mainStack)
        configureEmailField(in: topContainerStackView)
        configurePasswordField(in: topContainerStackView)
    }
    
    func configureLoginButton(in mainStack: UIStackView) {
        assert(mainStack.arrangedSubviews.count == 1)
        
        self.loginButton = UIButton()
        
        addView(loginButton, to: mainStack)
    }
    
    func configureEmailField(in topContainerStack: UIStackView) {
        assert(topContainerStack.arrangedSubviews.count == 0)
        
        self.emailField = UITextField()
        emailField.placeholder = Constants.emailPlaceholder
        emailField.backgroundColor = Theme.Color.textFieldBackground
        
        addView(emailField, to: topContainerStack)
    }
    
    func configurePasswordField(in topContainerStack: UIStackView) {
        assert(topContainerStack.arrangedSubviews.count == 1)
        
        self.passwordField = UITextField()
        passwordField.placeholder = Constants.passwordPlaceholder
        passwordField.backgroundColor = Theme.Color.textFieldBackground
        
        addView(passwordField, to: topContainerStack)
    }
    
    func addView(_ view: UIView, to stackView: UIStackView) {
        stackView.addArrangedSubview(view)
    }
}
