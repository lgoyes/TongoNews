//
//  AnyCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit

class AnyCoordinator<AcceptedNode>: CoordinatorType where AcceptedNode: Hashable {
    
    typealias Node = AcceptedNode
    
    var nodeManager: [AcceptedNode : Routable] = [:]
    var currentNode: AcceptedNode?
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() throws {
        guard let currentNode = self.currentNode, let node = nodeManager[currentNode] else {
            throw CoordinatorError.nodeIsNotDefined
        }
        if let coordinator = node as? StartableCoordinator {
            try coordinator.start()
        } else {
            let routableNode = node.getRoutable()
            self.navigationController.pushViewController(routableNode, animated: true)
        }
    }
    
    func setNode(node: AcceptedNode, routable: Routable) throws {
        nodeManager[node] = routable
    }
    
    func getRoutable() -> UIViewController {
        return navigationController
    }
}
