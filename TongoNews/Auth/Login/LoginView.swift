//
//  LoginView.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit

protocol LoginViewType: ViewType {
    
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
    
    func configureSubviews() {
        setMainContainer()
        configureTopContainerStackView(in: mainStackView)
        configureLoginButton(in: mainStackView)
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
        
        addView(loginButton, to: mainStack)
    }
    
    func configureEmailField(in topContainerStack: UIStackView) {
        assert(topContainerStack.arrangedSubviews.count == 0)
        
        self.emailField = UITextField()
        emailField.placeholder = Constant.emailPlaceholder
        emailField.backgroundColor = Theme.Color.textFieldBackground
        
        addView(emailField, to: topContainerStack)
    }
    
    func configurePasswordField(in topContainerStack: UIStackView) {
        assert(topContainerStack.arrangedSubviews.count == 1)
        
        self.passwordField = UITextField()
        passwordField.placeholder = Constant.passwordPlaceholder
        passwordField.backgroundColor = Theme.Color.textFieldBackground
        
        addView(passwordField, to: topContainerStack)
    }
    
    func addView(_ view: UIView, to stackView: UIStackView) {
        stackView.addArrangedSubview(view)
    }
}
