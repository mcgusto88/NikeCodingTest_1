//
//  NikeTop100Tests.swift
//  NikeTop100Tests
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest
@testable import NikeTop100

class NikeTop100Tests: XCTestCase {
    
    var viewController : AlbumsListViewController?
    
    override func setUpWithError() throws {
        let mockNetworkClient = MockHTTPClient()
        let mockLoader = MockAlbumsLoader(networkClient: mockNetworkClient,jsonDecoder: JSONDecoder())
        viewController = AlbumsListViewController(dataLoader: mockLoader, selectionHandler: {_ in
        })
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoaderGetAlbumsIsCalledOnce() throws {
        let mockNetworkClient = MockHTTPClient()
        let mockLoader = MockAlbumsLoader(networkClient: mockNetworkClient,jsonDecoder: JSONDecoder())
        viewController = AlbumsListViewController(dataLoader: mockLoader, selectionHandler: {_ in
        })
        viewController?.getAlbums(count: 1)
        XCTAssert(mockLoader.loadedCalled)
    }
    
    func testTableViewHas100AlbumsWhenViewControllerIsLoaded() throws {
        let _ = viewController?.view
        XCTAssert(viewController?.tableView.numberOfRows(inSection: 0) == 1)
    }
    
}


class MockHTTPClient : HTTPClient {
    
    func get(url: String, queryParameters: [String : String]?, completion: @escaping ((Result<Data, CustomError>) -> Void)) {
        if let data = NSData(contentsOfFile: url) {
            completion(.success(data as Data))
        }
    }
}

class MockAlbumsLoader : AlbumsDataLoader {
    var networkClient: HTTPClient
    var jsonDecoder: JSONDecoder
    var loadedCalled = false

    init(networkClient:HTTPClient,jsonDecoder:JSONDecoder) {
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
    func getAlbums(count: Int, completion: ((Result<[Album], CustomError>) -> Void)?) {
        loadedCalled = true
        let genre = Genre(genreId: "Id", name: "Genre Name", url: "Url")
        let album = Album(name: "Album Name", artistName: "Artist Name", id: "Id", imageUrl: "Image Url", genres: [genre], url: "Url", copyright: "CopyRight", releaseDate: "2020-01-01")
        completion?(.success([album]))
    }
}

