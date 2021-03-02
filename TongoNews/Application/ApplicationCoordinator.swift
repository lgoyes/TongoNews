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
    
    enum FlowType {
        case auth
    }
    
    var selectedFlow: FlowType
    let navigationController: UINavigationController
    var flowManager: [FlowType: CoordinatorType]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        selectedFlow = .auth
        flowManager = [FlowType.auth: AuthCoordinator(navigationController: navigationController)]
    }
    
    func getRoutable() -> UIViewController {
        return navigationController
    }
    
    func start() throws {
        guard let coordinator = flowManager[selectedFlow] else {
            throw ApplicationCoordinatorError.noCoordinatorWasAssociatedToFlowType
        }
        try coordinator.start()
    }
    
    func setFlow(flowType: FlowType, coordinator: CoordinatorType) {
        flowManager[flowType] = coordinator
    }
}

enum ApplicationCoordinatorError: Error {
    case noCoordinatorWasAssociatedToFlowType
}
