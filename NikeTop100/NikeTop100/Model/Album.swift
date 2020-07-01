//
//  Album.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import Foundation

struct AlbumFeed: Decodable {
    let results: [Album]
}

struct AlbumJson: Decodable {
    let feed: AlbumFeed
}

struct Album : Codable {
    let name : String
    let artistName: String
    let id : String
    let imageUrl : String
    let genres : [Genre]
    let url : String
    let copyright : String
    let releaseDate : String
    
    enum CodingKeys: String, CodingKey {
        case name
        case artistName
        case id
        case imageUrl = "artworkUrl100"
        case genres
        case url
        case copyright
        case releaseDate
    }

}


struct Genre  : Codable {
    let genreId : String
    let name : String
    let url : String
}
