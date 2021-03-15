//
//  AuthCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol AuthCoordinatorType {

}

final class AuthCoordinator: AnyCoordinator<AuthCoordinator.Node>, AuthCoordinatorType {
    enum Node {
        case login
    }
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        self.currentNode = .login
        nodeManager = [.login:LoginViewController(entity: LoginEntity())]
    }
}
