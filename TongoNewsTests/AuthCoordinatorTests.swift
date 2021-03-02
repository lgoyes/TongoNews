//
//  AuthCoordinatorTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 2/03/21.
//

import XCTest
@testable import TongoNews

class AuthCoordinatorTests: XCTestCase {
    
    var sut: AuthCoordinatorType!

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
}
