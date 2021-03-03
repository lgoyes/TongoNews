//
//  AuthCoordinatorTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 2/03/21.
//

import XCTest
@testable import TongoNews

class AuthCoordinatorTests: XCTestCase {
    
    var sut: AnyCoordinator<AuthCoordinatorNode>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_GivenANavigationControllerWasInjected_WhenAsRoutableIsInvoked_ThenReturnTheInjectedNavigationController() {
        let navigationController = UINavigationController()
        sut = AuthCoordinator(navigationController: navigationController)
        let presentedViewController = sut.getRoutable()
        XCTAssertEqual(presentedViewController, navigationController)
    }
    
    func test_WhenInitialized_ThenTheSelectedNodeShouldBeLogin() {
        let sutImplementation = sut as! AuthCoordinator
        let selectedFlow = sutImplementation.currentNode
        XCTAssertEqual(selectedFlow, AuthCoordinator.Node.login)
    }
    
    func test_WhenInitialized_ThenTheNodeForLoginShouldBeALoginController() {
        let sutImplementation = sut as! AuthCoordinator
        let associatedNode = sutImplementation.nodeManager[.login]
        XCTAssertTrue(associatedNode is LoginControllerType)
    }
    
    func test_GivenAnExistingNodeForLogin_WhenSetNodeIsInvokedForLogin_ThenChangeTheNodeInstance() throws {
        let sutImplementation = sut as! AuthCoordinator
        let mockLoginController = MockViewController()
        try sutImplementation.setNode(node: AuthCoordinator.Node.login, routable: mockLoginController)
        
        let selectedNode = sutImplementation.nodeManager[.login]
        XCTAssertTrue(selectedNode === mockLoginController)
    }
    
    func test_WhenSetNodeIsInvokedForANonAcceptedNode_ThenThrowAnError() {
        let sutImplementation = sut as! AuthCoordinator
        let mockAuthCoordinator = MockViewController()
        XCTAssertThrowsError(try sutImplementation.setNode(node: ApplicationCoordinator.Node.auth, routable: mockAuthCoordinator))
    }
}
