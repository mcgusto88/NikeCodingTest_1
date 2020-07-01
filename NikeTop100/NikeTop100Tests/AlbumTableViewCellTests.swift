//
//  AlbumTableViewCellTests.swift
//  NikeTop100Tests
//
//  Created by Augustus Wilson on 6/29/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumTableViewCellTests: XCTestCase {

    let albumCell = AlbumTableViewCell()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumCellHasImage() throws {
        XCTAssertNotNil(albumCell.albumImage)
        XCTAssertEqual(albumCell.albumImage.accessibilityIdentifier, "Album Image")
    }

    func testAlbumCellHasAlbumName() throws {
        XCTAssertNotNil(albumCell.albumName)
        XCTAssertEqual(albumCell.albumName.accessibilityIdentifier, "Album Name")
    }
    
    func testAlbumCellHasArtistName() throws {
        XCTAssertNotNil(albumCell.artistName)
        XCTAssertEqual(albumCell.artistName.accessibilityIdentifier, "Artist Name")
    }
    
    func testAlbumCellAssignsTheValuesFromPassedAlbum() throws {
        let genre = Genre(genreId: "Id", name: "Genre Name", url: "Url")
        let album = Album(name: "Test Album Name", artistName: "Test Artist Name", id: "Id", imageUrl: "Image Url", genres: [genre], url: "Url", copyright: "CopyRight", releaseDate: "2020-01-01")
        albumCell.refreshWith(album: album)
        
        XCTAssertEqual(albumCell.albumName.text, "Test Album Name")
        XCTAssertEqual(albumCell.artistName.text, "Test Artist Name")
    }


}
