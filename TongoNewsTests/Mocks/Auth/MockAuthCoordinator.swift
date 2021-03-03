//
//  MockAuthCoordinator.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit
@testable import TongoNews

final class MockAuthCoordinator: AuthCoordinatorType {
    
    
    
    lazy var currentViewController: UIViewController = {
        return MockViewController()
    }()
    
    var onStart: (() -> ())?
    var onSetNode: (() -> ())?
    
    func getRoutable() -> UIViewController {
        return currentViewController
    }
    
    func start() {
        onStart?()
    }
    
    func setNode<T>(node: T, routable: Routable) throws where T : RoutableNode {
        onSetNode?()
    }
}
