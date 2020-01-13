//
//  MovieResponse.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 18/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieResponse: Mappable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [Movie]?
    
    func mapping(map: Map) {
        page <- map["page"]
        total_results <- map["total_results"]
        total_pages <- map["total_pages"]
        results <- map["results"]        
    }
    
    required init?(map: Map){
    }
}
