//
//  AlbumsDataLoaderTests.swift
//  NikeTop100Tests
//
//  Created by Augustus Wilson on 6/30/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumsDataLoaderTests: XCTestCase {
        
    let mockFeed =   """
    {
        "feed": {
            "results": [
                {
                    "artistName": "Lil Durk",
                    "id": "1519881180",
                    "releaseDate": "2020-06-26",
                    "name": "Just Cause Y'all Waited 2 (Deluxe)",
                    "kind": "album",
                    "copyright": "℗ 2020 Alamo (Geffen Records)",
                    "artistId": "541282483",
                    "contentAdvisoryRating": "Explicit",
                    "artistUrl": "https://music.apple.com/us/artist/lil-durk/541282483?app=music",
                    "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music123/v4/bf/cc/4f/bfcc4f53-db3b-95e8-13a3-e1d40010a4a9/20UMGIM49384.rgb.jpg/200x200bb.png",
                    "genres": [
                        {
                            "genreId": "18",
                            "name": "Hip-Hop/Rap",
                            "url": "https://itunes.apple.com/us/genre/id18"
                        },
                        {
                            "genreId": "34",
                            "name": "Music",
                            "url": "https://itunes.apple.com/us/genre/id34"
                        }
                    ],
                    "url": "https://music.apple.com/us/album/just-cause-yall-waited-2-deluxe/1519881180?app=music"
                }
            ]
        }
    }
  """

    
      let mockIncorrectFeed =   """
      {
          "feed1": {
              "results": [
                  {
                      "artistName": "Lil Durk",
                      "id": "1519881180",
                      "releaseDate": "2020-06-26",
                      "name": "Just Cause Y'all Waited 2 (Deluxe)",
                      "kind": "album",
                      "copyright": "℗ 2020 Alamo (Geffen Records)",
                      "artistId": "541282483",
                      "contentAdvisoryRating": "Explicit",
                      "artistUrl": "https://music.apple.com/us/artist/lil-durk/541282483?app=music",
                      "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music123/v4/bf/cc/4f/bfcc4f53-db3b-95e8-13a3-e1d40010a4a9/20UMGIM49384.rgb.jpg/200x200bb.png",
                      "genres": [
                          {
                              "genreId": "18",
                              "name": "Hip-Hop/Rap",
                              "url": "https://itunes.apple.com/us/genre/id18"
                          },
                          {
                              "genreId": "34",
                              "name": "Music",
                              "url": "https://itunes.apple.com/us/genre/id34"
                          }
                      ],
                      "url": "https://music.apple.com/us/album/just-cause-yall-waited-2-deluxe/1519881180?app=music"
                  }
              ]
          }
      }
    """

    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAlbumModalIsProperlyDecodedWhenProperDataIsReturned() throws {
        let data = Data(mockFeed.utf8)
        let expect = expectation(description: "Completion called succesfully")
        let networkClient = MockNetworkClient(data: data, error: nil)
        let albumLoader = RemoteAlbumsLoader(networkClient: networkClient, jsonDecoder: JSONDecoder())
        var expectedAlbums : [Album]? = nil
        albumLoader.getAlbums(count: 10) { (result) in
            guard case .success(let albums) = result else {
                expect.fulfill();
                return }
            expectedAlbums = albums
            expect.fulfill();
        }
                
        networkClient.get(url: "https://www.example.com", queryParameters: nil) { result in
        }
        
        wait(for: [expect], timeout: 1)
        XCTAssertNotNil(expectedAlbums)
    }

    func testDecodeErrorIsWhenInproperDataIsReturned() throws {
        let data = Data(mockIncorrectFeed.utf8)
        let expect = expectation(description: "Completion called succesfully")
        let networkClient = MockNetworkClient(data: data, error: nil)
        let albumLoader = RemoteAlbumsLoader(networkClient: networkClient, jsonDecoder: JSONDecoder())
        var returnedError : CustomError? = nil
        albumLoader.getAlbums(count: 10) { (result) in
            guard case .failure(let error) = result else {
                expect.fulfill();
                return }
            returnedError = error
            expect.fulfill();
        }
                
        networkClient.get(url: "https://www.example.com", queryParameters: nil) { result in
        }
        
        wait(for: [expect], timeout: 1)
        XCTAssertNotNil(returnedError)
        XCTAssertEqual(returnedError, CustomError.decodeError)

    }

    func testErrorIsWhenProperDataIsReturned() throws {
        let data = Data(mockIncorrectFeed.utf8)
        let expect = expectation(description: "Completion called succesfully")
        let networkClient = MockNetworkClient(data: data, error: CustomError.serverError)
        let albumLoader = RemoteAlbumsLoader(networkClient: networkClient, jsonDecoder: JSONDecoder())
        var returnedError : CustomError? = nil
        albumLoader.getAlbums(count: 10) { (result) in
            guard case .failure(let error) = result else {
                expect.fulfill();
                return }
            returnedError = error
            expect.fulfill();
        }
                
        networkClient.get(url: "https://www.example.com", queryParameters: nil) { result in
        }
        
        wait(for: [expect], timeout: 1)
        XCTAssertNotNil(returnedError)
        XCTAssertEqual(returnedError, CustomError.serverError)

    }

}


class MockNetworkClient: HTTPClient {
    
    var data : Data?
    var error : CustomError?
    
    init(data:Data?,error:CustomError?) {
        self.data = data
        self.error = error
    }
    
    func get(url: String, queryParameters: [String : String]?, completion: @escaping ((Result<Data, CustomError>) -> Void)) {
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            completion(.success(data))
        }
    }
    
}
