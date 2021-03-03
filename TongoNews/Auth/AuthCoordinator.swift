//
//  AuthCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol AuthCoordinatorType: CoordinatorType {

}

enum AuthCoordinatorNode: RoutableNode {
    case login
}

final class AuthCoordinator: AnyCoordinator<AuthCoordinatorNode>, AuthCoordinatorType {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        self.currentNode = .login
        nodeManager = [.login:LoginViewController()]
    }
    
    override func start() throws {
        guard let currentNode = self.currentNode, let node = nodeManager[currentNode] else {
            throw CoordinatorError.nodeIsNotDefined
        }
        let routableNode = node.getRoutable()
        self.navigationController.pushViewController(routableNode, animated: true)
    }
    
    func setNode<T>(node: T, routable: Routable) throws where T : RoutableNode {
        guard let acceptedNode = node as? Node else {
            throw CoordinatorError.unableToSetRoutableNode
        }
        nodeManager[acceptedNode] = routable
    }
}
