//
//  AlbumsDetailsViewControllerTests.swift
//  NikeTop100Tests
//
//  Created by Augustus Wilson on 6/29/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumsDetailsViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumViewIsAddedToAlbumsDetailsViewController() throws {
        let albumsView = AlbumDetailView()
        let genre = Genre(genreId: "Id", name: "Genre Name", url: "Url")
        let album = Album(name: "Test Album Name", artistName: "Test Artist Name", id: "Id", imageUrl: "Image Url", genres: [genre], url: "Url", copyright: "CopyRight", releaseDate: "2020-01-01")
        let detailsVC = AlbumDetailsViewController(album: album, detailView: albumsView)
        
        XCTAssertTrue(albumsView.isDescendant(of: detailsVC.view));
    }
    
    func testAlbumViewHasBeenPopulatedCorrectlyWithAlbumPassed() throws {
        let albumsView = AlbumDetailView()
        let genre = Genre(genreId: "Id", name: "Genre Name", url: "Url")
        let album = Album(name: "Test Album Name", artistName: "Test Artist Name", id: "Id", imageUrl: "Image Url", genres: [genre], url: "Url", copyright: "CopyRight", releaseDate: "2020-01-01")
        let detailsVC = AlbumDetailsViewController(album: album, detailView: albumsView)
        let _ = detailsVC.view
        XCTAssertEqual(albumsView.albumName.text, "Test Album Name")
        XCTAssertEqual(albumsView.artistName.text, "Test Artist Name")
        XCTAssertEqual(albumsView.copyright.text, "CopyRight")
        XCTAssertEqual(albumsView.genre.text, "Genre Name")
        XCTAssertEqual(albumsView.releaseDate.text, "2020-01-01")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
