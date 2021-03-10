//
//  FakeAuthCoordinator.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit
@testable import TongoNews

final class FakeAuthCoordinator: AnyCoordinator<AuthCoordinator.Node> {
    
    lazy var currentViewController: UIViewController = {
        return FakeViewController()
    }()
    
    init() {
        super.init(navigationController: UINavigationController())
    }
    
    private var startCalled = false
    private var nodes: [AuthCoordinator.Node: Routable] = [:]
    
    override func start() throws {
        startCalled = true
    }
    
    override func setNode(node: AuthCoordinator.Node, routable: Routable) throws {
        nodes[node] = routable
    }
    
    func wasStartCalled() -> Bool {
        return startCalled
    }
    
    func getRoutable(for node: AuthCoordinator.Node) -> Routable? {
        return nodes[node]
    }
}
