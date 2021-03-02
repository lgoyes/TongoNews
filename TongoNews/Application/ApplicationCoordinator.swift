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
    
    enum Node {
        case auth
    }
    
    var currentNode: Node
    let navigationController: UINavigationController
    var nodeManager: [Node: Routable]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        currentNode = .auth
        nodeManager = [.auth: AuthCoordinator(navigationController: navigationController)]
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
    
    func setFlow(flowType: Node, coordinator: CoordinatorType) {
        nodeManager[flowType] = coordinator
    }
}

enum ApplicationCoordinatorError: Error {

}
