//
//  ApplicationCoordinatorTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import XCTest
@testable import TongoNews

class ApplicationCoordinatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldCreateAnApplicationCoordinatorWithAUINavigationController() throws {
        let coordinator = ApplicationCoordinator(navigationController: UINavigationController())
        XCTAssertNotNil(coordinator)
    }
}
