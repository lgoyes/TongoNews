//
//  AuthCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol AuthCoordinatorType: CoordinatorType {
    
}

final class AuthCoordinator: AuthCoordinatorType {
    
    enum Node {
        case login
    }
    
    var selectedNode: Node
    var nodeManager: [Node: Routable]
    
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.selectedNode = .login
        nodeManager = [:]
    }
    
    func getRoutable() -> UIViewController {
        return navigationController
    }
    
    func start() {
        
    }
}
