//
//  ApplicationCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol CoordinatorType: AnyObject {
    func asRoutable() -> UIViewController
    func start() throws
}

protocol ApplicationCoordinatorType: CoordinatorType {
    
}

final class ApplicationCoordinator: ApplicationCoordinatorType {
    
    enum FlowType: String {
        case auth
    }
    
    var selectedFlow: FlowType
    let navigationController: UINavigationController
    
    var flowManager: [FlowType: CoordinatorType]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        selectedFlow = .auth
        flowManager = [FlowType.auth: AuthCoordinator()]
    }
    
    func asRoutable() -> UIViewController {
        return navigationController
    }
    
    func start() throws {
        guard let coordinator = flowManager[selectedFlow] else {
            throw ApplicationCoordinatorError.noCoordinatorWasAssociatedToFlowType
        }
        let currentViewController = coordinator.asRoutable()
        navigationController.pushViewController(currentViewController, animated: true)
    }
    
    func setFlow(flowType: FlowType, coordinator: CoordinatorType) {
        flowManager[flowType] = coordinator
    }
}

enum ApplicationCoordinatorError: Error {
    case noCoordinatorWasAssociatedToFlowType
}
