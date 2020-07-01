//
//  AlbumListNavigationCoordinatorTest.swift
//  NikeTop100Tests
//
//  Created by Augustus Wilson on 6/29/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumListNavigationCoordinatorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerIsOfNavigationControllerClass() throws {
        let navigationCoordiantor =  AlbumListNavigationCoordinator()
        let navigationController = navigationCoordiantor.getInitialViewController()
        XCTAssertTrue(navigationController.isKind(of: UINavigationController.self))
    }
    
    func testAlbumListViewControllerIsNavigationFirstViewController() throws {
        let navigationCoordiantor =  AlbumListNavigationCoordinator()
        let navigationController = navigationCoordiantor.getInitialViewController()
        let viewController = navigationController.viewControllers.first
        XCTAssertNotNil(viewController)
        XCTAssert(viewController!.self is AlbumListSummaryUI)
    }

    
}
