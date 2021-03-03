//
//  MockAuthCoordinator.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit
@testable import TongoNews

final class MockAuthCoordinator: AnyCoordinator<AuthCoordinatorNode> {
    
    lazy var currentViewController: UIViewController = {
        return MockViewController()
    }()
    
    init() {
        super.init(navigationController: UINavigationController())
    }
    
    var onStart: (() -> ())?
    var onSetNode: (() -> ())?
    
    override func start() throws {
        onStart?()
    }
    
    override func setNode(node: AuthCoordinatorNode, routable: Routable) throws {
        onSetNode?()
    }
}
