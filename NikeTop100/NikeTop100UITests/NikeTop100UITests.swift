//
//  NikeTop100UITests.swift
//  NikeTop100UITests
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest

class NikeTop100UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumListExists() throws {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables["Albums List"]
        assert(tableView.exists)
    }
    
    func testLoadingIndicatorShowsOnLoad() throws {
        let app = XCUIApplication()
        app.launch()
        let loadingIndicator = app.activityIndicators["Album Loading Indicator"]
        assert(loadingIndicator.exists)
    }
    
    func testAlbumNameExistsAfterLoad() throws {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables["Albums List"]
        let tableViewCell = tableView.cells.element(boundBy: 0)
        assert(tableViewCell.waitForExistence(timeout: 3),"Albums Failed within 3 seconds")
        let albumName = tableViewCell.staticTexts["Album Name"]
        assert(albumName.exists, "Album Name is not displayed")
        
        let artistName = tableViewCell.staticTexts["Artist Name"]
        assert(artistName.exists, "Artist Name is not displayed")

        let image = tableViewCell.images["Album Image"]
        assert(image.exists, "Album Image is not displayed")
        XCTAssertNotNil(image)
    }

    
    func testAlbumCellHasRequiredElements() throws {
        let app = XCUIApplication()
        app.launch()
    }


}
