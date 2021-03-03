//
//  ApplicationCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol ApplicationCoordinatorType {
    
}



final class ApplicationCoordinator: AnyCoordinator<ApplicationCoordinator.Node>, ApplicationCoordinatorType {
    
    enum Node {
        case auth
    }
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        currentNode = .auth
        nodeManager = [Node.auth: AuthCoordinator(navigationController: navigationController)]
    }
}

enum ApplicationCoordinatorError: Error {

}
