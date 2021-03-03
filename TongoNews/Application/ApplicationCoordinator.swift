//
//  ApplicationCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol ApplicationCoordinatorType: CoordinatorType {
    
}

final class ApplicationCoordinator: ApplicationCoordinatorType {
    
    enum Node: String, RoutableNode {
        case auth
    }
    
    var currentNode: Node
    let navigationController: UINavigationController
    var nodeManager: [Node: Routable]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        currentNode = .auth
        nodeManager = [Node.auth: AuthCoordinator(navigationController: navigationController)]
    }
    
    func getRoutable() -> UIViewController {
        return navigationController
    }
    
    func start() throws {
        guard let node = nodeManager[currentNode] else {
            throw CoordinatorError.nodeIsNotDefined
        }
        if let coordinator = node as? CoordinatorType {
            try coordinator.start()
        }
    }
    
    func setNode<T>(node: T, routable: Routable) throws where T : RoutableNode {
        guard let acceptedNode = node as? Node else {
            throw CoordinatorError.unableToSetRoutableNode
        }
        nodeManager[acceptedNode] = routable
    }
}

enum ApplicationCoordinatorError: Error {

}
