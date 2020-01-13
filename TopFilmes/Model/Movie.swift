//
//  Movie.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 18/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
    var backdrop_path: String?
    var popularity: NSNumber?
    var vote_count: NSNumber?
    var video: Bool?
    var vote_average: NSNumber?
    var release_date: String?
    var genre_ids: [Int]?
    var adult: Bool?
    var overview: String?
    var poster_path: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        original_title <- map["original_title"]
        original_language <- map["original_language"]
        title <- map["title"]
        backdrop_path <- map["backdrop_path"]
        popularity <- map["backdrop_path"]
        vote_count <- map["backdrop_path"]
        video <- map["video"]
        vote_average <- map["vote_count"]
        release_date <- map["release_date"]
        genre_ids <- map["genre_ids"]
        adult <- map["adult"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
    }
    
    required init?(map: Map){
        
    }
    
    init() {}
}
