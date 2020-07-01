//
//  AlbumDetailViewTest.swift
//  NikeTop100Tests
//
//  Created by Augustus Wilson on 6/29/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumDetailViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testDetailViewHasImage() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.imageView)
        XCTAssertEqual(detailView.imageView.accessibilityIdentifier, "Album Image")
    }

    func testDetailViewHasAlbumName() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.albumName)
        XCTAssertEqual(detailView.albumName.accessibilityIdentifier, "Album Name")
    }
    
    func testDetailViewHasArtistName() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.artistName)
        XCTAssertEqual(detailView.artistName.accessibilityIdentifier, "Artist Name")
    }

    func testDetailViewHasCopyright() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.copyright)
        XCTAssertEqual(detailView.copyright.accessibilityIdentifier, "Copyright")
    }

    func testDetailViewHasGenre() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.genre)
        XCTAssertEqual(detailView.genre.accessibilityIdentifier, "Genre")
    }

    func testDetailViewHasItunesButton() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.iTunesButton)
        XCTAssertEqual(detailView.iTunesButton.accessibilityIdentifier, "View In iTunes")
    }

    func testDetailViewHasReleaseDate() throws {
        let detailView = AlbumDetailView()
        XCTAssertNotNil(detailView.releaseDate)
        XCTAssertEqual(detailView.releaseDate.accessibilityIdentifier, "Release Date")
    }

    func testDetailViewHasPlacedholderViewAddedToView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(placeholder.isDescendant(of: detailView));
    }

    func testDetailViewHasAlbumNameAddedtoPlaceholderView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(detailView.albumName.isDescendant(of: placeholder));
    }

    func testDetailViewHasArtistNameAddedtoPlaceholderView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(detailView.artistName.isDescendant(of: placeholder));
    }

    func testDetailViewHasGenreAddedtoPlaceholderView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(detailView.genre.isDescendant(of: placeholder));
    }

    func testDetailViewHasReleaseDataAddedtoPlaceholderView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(detailView.releaseDate.isDescendant(of: placeholder));
    }

    func testDetailViewHasCopyrightAddedtoPlaceholderView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(detailView.copyright.isDescendant(of: placeholder));
    }
    
    func testDetailViewHasViewInItunesAddedtoPlaceholderView() throws {
        let detailView = AlbumDetailView()
        let placeholder = detailView.placeholderView;
        XCTAssertTrue(detailView.iTunesButton.isDescendant(of: placeholder));
    }
    
}
