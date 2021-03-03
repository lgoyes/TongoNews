//
//  ApplicationCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol ApplicationCoordinatorType: CoordinatorType {
    
}

enum ApplicationCoordinatorNode: RoutableNode {
    case auth
}

final class ApplicationCoordinator: AnyCoordinator<ApplicationCoordinatorNode>, ApplicationCoordinatorType {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        currentNode = .auth
        nodeManager = [Node.auth: AuthCoordinator(navigationController: navigationController)]
    }
    
    override func start() throws {
        guard let currentNode = self.currentNode, let node = nodeManager[currentNode] else {
            throw CoordinatorError.nodeIsNotDefined
        }
        if let coordinator = node as? AnyCoordinator<AuthCoordinatorNode> {
            try coordinator.start()
        }
    }
}

enum ApplicationCoordinatorError: Error {

}
