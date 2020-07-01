//
//  AlbumService.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import Foundation

protocol AlbumsDataLoader {
    var networkClient : HTTPClient { get }
    var jsonDecoder : JSONDecoder { get }
    func getAlbums(count:Int , completion: ((Result<[Album],CustomError>)->Void)?);
}

class RemoteAlbumsLoader : AlbumsDataLoader {
    var networkClient: HTTPClient
    var jsonDecoder: JSONDecoder
    init(networkClient:HTTPClient,jsonDecoder:JSONDecoder) {
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
    private let albumsBaseUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/";
    
    func getAlbums(count: Int, completion: ((Result<[Album], CustomError>) -> Void)?) {
        let albumsUrl = albumsBaseUrl + "\(count)/explicit.json"
        networkClient.get(url: albumsUrl, queryParameters: nil) {  [weak self] result in
            guard let self = self else {return}
            switch(result){
            case .success(let data):
                do {
                    let albums = try self.jsonDecoder.decode(AlbumJson.self, from: data).feed.results
                    completion?(.success(albums))
                }
                catch (let error) {
                    print(error)
                    completion?(.failure(.decodeError))
                }
                break;
            case.failure(let error):
                completion?(.failure(error))
            }
        }
    }
}



