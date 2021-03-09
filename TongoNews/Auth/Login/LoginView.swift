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
        static let email = "Email"
        static let password = "Password"
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = Constants.email
        return emailField
    }()
    
    lazy var passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = Constants.password
        return passwordField
    }()
    
    var subviewsAreConfigured = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureSubviews() {
        setMainContainer(mainStackView)
        addField(emailField, to: mainStackView)
        addField(passwordField, to: mainStackView)
        subviewsAreConfigured = true
    }
    
    func setMainContainer(_ stackView: UIStackView) {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func addField(_ textField: UITextField, to stackView: UIStackView) {
        stackView.addArrangedSubview(textField)
    }
}
