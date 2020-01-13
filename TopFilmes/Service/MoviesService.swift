//
//  MoviesService.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 18/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation

class MoviesService {
    
    func getTopMovies(page: Int, completionHandler: @escaping (DataResponse<MovieResponse>) -> Void) {
        DispatchQueue.main.async {
            let requestUrl: String = "\(APIManager.baseUrl)movie/popular?api_key=\(APIManager.key)&language=pt-BR&page=\(page)"
            guard let url = URL(string: requestUrl) else { return }
            Alamofire.request(url).responseObject { (response: DataResponse<MovieResponse>) in
                completionHandler(response)
            }
        }
    }
    
    func getMoviesFromFilter(filter: MoviesFilter, page: Int, completionHandler: @escaping (DataResponse<MovieResponse>) -> Void) {
        DispatchQueue.main.async {
            let text: String = filter.text
            let year: String = filter.year
            
            let requestUrl: String = "\(APIManager.baseUrl)search/movie?api_key=\(APIManager.key)&language=pt-BR&page=\(page)&query=\(text)&year=\(year)"
            
            print("======\(requestUrl)")
            
            guard let url = URL(string: requestUrl) else { return }
            Alamofire.request(url).responseObject { (response: DataResponse<MovieResponse>) in
                completionHandler(response)
            }
        }
    }
    
    func getMovieDetails(movieId: Int,completionHandler: @escaping (DataResponse<MovieDetails>) -> Void) {
        DispatchQueue.main.async {
            let requestUrl: String = "\(APIManager.baseUrl)movie/\(movieId)?api_key=\(APIManager.key)&language=pt-BR"
            
            guard let url = URL(string: requestUrl) else { return }
            Alamofire.request(url).responseObject { (response: DataResponse<MovieDetails>) in
                completionHandler(response)
            }
        }
    }
}
