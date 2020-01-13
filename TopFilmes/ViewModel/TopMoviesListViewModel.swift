//
//  TopMoviesListViewModel.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 17/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import Foundation

protocol TopMoviesListProtocol {
    func didLoadMovies(movies: [Movie])
    func didFailedLoadMovies()
}

class TopMoviesListViewModel {
    var delegate: TopMoviesListProtocol
    private let service = MoviesService()
    
    init(delegate: TopMoviesListProtocol) {
        self.delegate = delegate
    }
    
    public func loadTopMovies(page: Int) {
        service.getTopMovies(page: page) { (response) in
            if response.error != nil {
                self.delegate.didFailedLoadMovies()
            
            } else {
                let movies = response.result.value?.results
                self.delegate.didLoadMovies(movies: movies ?? [])
            }
        }
    }
    
    public func loadMoviesFromFilter(filter: MoviesFilter, page: Int) {
        service.getMoviesFromFilter(filter: filter, page: page) { (response) in
            if response.error != nil {
                self.delegate.didFailedLoadMovies()
                
            } else {
                let movies = response.result.value?.results
                self.delegate.didLoadMovies(movies: movies ?? [])
            }
        }
    }
}
