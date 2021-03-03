//
//  ApplicationCoordinatorTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import XCTest
@testable import TongoNews

class ApplicationCoordinatorTests: XCTestCase {
    
    var sut: ApplicationCoordinatorType!
    var mockAuthCoordinator: MockAuthCoordinator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAuthCoordinator = MockAuthCoordinator()
        let sutImplementation = ApplicationCoordinator(navigationController: UINavigationController())
        try sutImplementation.setNode(node: ApplicationCoordinator.Node.auth, routable: mockAuthCoordinator)
        sut = sutImplementation
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_GivenANavigationControllerWasInjected_WhenAsRoutableIsInvoked_ThenReturnTheInjectedNavigationController() throws {
        let navigationController = UINavigationController()
        let sutImplementation = ApplicationCoordinator(navigationController: navigationController)
        try sutImplementation.setNode(node: ApplicationCoordinator.Node.auth, routable: mockAuthCoordinator)
        sut = sutImplementation
        let presentedViewController = sut.getRoutable()
        XCTAssertEqual(presentedViewController, navigationController)
    }
    
    func test_WhenInitialized_ThenTheSelectedNodeShouldBeAuth() {
        let sutImplementation = sut as! ApplicationCoordinator
        let selectedNode = sutImplementation.currentNode
        XCTAssertEqual(selectedNode, ApplicationCoordinator.Node.auth)
    }
    
    func test_WhenInitialized_ThenTheNodeForTheAuthShouldBeAnAuthCoordinator() {
        let sutImplementation = sut as! ApplicationCoordinator
        let associatedCoordinator = sutImplementation.nodeManager[.auth]
        XCTAssertTrue(associatedCoordinator is AuthCoordinatorType)
    }
    
    func test_GivenAnExistingNodeForAuth_WhenSetNodeIsInvokedForAuth_ThenChangeTheNodeInstance() throws {
        let sutImplementation = sut as! ApplicationCoordinator
        let mockAuthCoordinator = MockAuthCoordinator()
        try sutImplementation.setNode(node: ApplicationCoordinator.Node.auth, routable: mockAuthCoordinator)
        
        let selectedNode = sutImplementation.nodeManager[ApplicationCoordinator.Node.auth]
        XCTAssertTrue(selectedNode === mockAuthCoordinator)
    }
    
    func test_WhenSetNodeIsInvokedForANonAcceptedNode_ThenThrowAnError() {
        let sutImplementation = sut as! ApplicationCoordinator
        let mockAuthCoordinator = MockAuthCoordinator()
        XCTAssertThrowsError(try sutImplementation.setNode(node: AuthCoordinator.Node.login, routable: mockAuthCoordinator))
    }
    
    func test_GivenAMockedVersionOfTheAuthCoordinator_WhenStartIsInvoked_ThenAuthCoordinatorStartFunctionShouldBeInvoked() throws {
        let sutImplementation = sut as! ApplicationCoordinator
        let expectation = XCTestExpectation(description: "Start method is called on auth coordinator")
        let mockAuthCoordinator = MockAuthCoordinator()
        mockAuthCoordinator.onStart = {
            expectation.fulfill()
        }
        try sutImplementation.setNode(node: ApplicationCoordinator.Node.auth, routable: mockAuthCoordinator)
        
        try sut.start()
         
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_GivenThatNoCoordinatorIsAssignedToTheAuthFlow_WhenStartIsInvoked_ThenShouldThrowError() {
        let sutImplementation = sut as! ApplicationCoordinator
        sutImplementation.nodeManager[.auth] = nil
        
        XCTAssertThrowsError(try sut.start())
    }
}
