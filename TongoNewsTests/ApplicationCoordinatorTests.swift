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

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ApplicationCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_GivenANavigationControllerWasInjected_WhenAsRoutableIsInvoked_ThenReturnTheInjectedNavigationController() {
        let navigationController = UINavigationController()
        sut = ApplicationCoordinator(navigationController: navigationController)
        let presentedViewController = sut.asRoutable()
        XCTAssertEqual(presentedViewController, navigationController)
    }
    
    func test_WhenInitialized_ThenTheSelectedFlowShouldBeAuth() {
        let sutImplementation = sut as! ApplicationCoordinator
        let selectedFlow = sutImplementation.selectedFlow
        XCTAssertEqual(selectedFlow, ApplicationCoordinator.FlowType.auth)
    }
    
    func test_WhenInitialized_ThenTheCoordinatorForTheAuthFlowShouldBeAnAuthCoordinator() {
        let sutImplementation = sut as! ApplicationCoordinator
        let associatedCoordinator = sutImplementation.flowManager[.auth]
        XCTAssertTrue(associatedCoordinator is AuthCoordinator)
    }
    
    func test_GivenAnExistingCoordinatorForAuthFlow_WhenSetFlowIsInvokedForAuthFlow_ThenChangeTheFlowInstance() {
        let sutImplementation = sut as! ApplicationCoordinator
        
        let mockAuthCoordinator = MockAuthCoordinator()
        sutImplementation.setFlow(flowType: .auth, coordinator: mockAuthCoordinator)
        
        let selectedFlow = sutImplementation.flowManager[.auth]
        XCTAssertTrue(selectedFlow === mockAuthCoordinator)
    }
    
    func test_GivenAMockedVersionOfTheAuthCoordinator_WhenStartIsInvoked_ThenPushTheMockViewController() throws {
        let sutImplementation = sut as! ApplicationCoordinator
        let mockAuthCoordinator = MockAuthCoordinator()
        sutImplementation.setFlow(flowType: .auth, coordinator: mockAuthCoordinator)
        
        try sut.start()
        
        let currentViewController = sutImplementation.navigationController.viewControllers.first
        XCTAssertTrue(currentViewController === mockAuthCoordinator.currentViewController)
    }
    
    func test_GivenThatNoCoordinatorIsAssignedToTheAuthFlow_WhenStartIsInvoked_ThenShouldThrowError() {
        let sutImplementation = sut as! ApplicationCoordinator
        sutImplementation.flowManager[.auth] = nil
        
        XCTAssertThrowsError(try sut.start())
    }
}
