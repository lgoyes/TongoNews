//
//  AnyCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 3/03/21.
//

import UIKit

class AnyCoordinator<AcceptedNode>: CoordinatorType where AcceptedNode: Hashable, AcceptedNode: RoutableNode {
    
    typealias Node = AcceptedNode
    
    var nodeManager: [AcceptedNode : Routable] = [:]
    var currentNode: AcceptedNode?
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() throws {
        assertionFailure("This method must be overriden")
    }
    
    func setNode(node: AcceptedNode, routable: Routable) throws {
        nodeManager[node] = routable
    }
    
    func getRoutable() -> UIViewController {
        return navigationController
    }
}
