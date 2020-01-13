//
//  TopFilmesTests.swift
//  TopFilmesTests
//
//  Created by Rodrigo Prado de Albuquerque on 17/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import XCTest
@testable import TopFilmes

class TopFilmesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Storyboard error")
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TopMoviesListVC") as? TopMoviesListVC else {
            XCTAssert(false, "Can't instantiate MoviesFilterVC")
            return
        }
        
        _ = vc.view
        
        XCTAssert(vc.loading.isHidden == false, "loading state failed")
        
        vc.setupViewState(state: .empty)
        XCTAssert(vc.emptyLabel.text == "Nenhum resultado encontrado", "empty state failed")
        
        vc.didFailedLoadMovies()
        XCTAssert(vc.emptyLabel.text == "Erro ao processar sua solicitação", "error state failed")
        
        vc.didLoadMovies(movies: self.mockMovies())
        XCTAssert(vc.collectionView.isHidden == false, "showing state failed")
    }
    
    func testFavoritesList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Storyboard error")
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "FavoritesVC") as? FavoritesVC else {
            XCTAssert(false, "Can't instantiate FavoritesVC")
            return
        }
        
        _ = vc.view
        
        vc.didLoadMovies(favoriteMovies: self.mockFavoriteMovies())
        XCTAssert(vc.collectionView.isHidden == false, "showing state failed")
        
        vc.didLoadMovies(favoriteMovies: [])
        
        XCTAssert(vc.emptyLabel.text == "Você não tem favoritos", "empty state failed")
        XCTAssert(vc.emptyLabel.isHidden == false, "empty state failed")
    }
    
    func testDetailsView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Storyboard error")
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC else {
            XCTAssert(false, "Can't instantiate MovieDetailsVC")
            return
        }
        
        let movie = Movie()
        movie.id = 1
        movie.title = "teste 1"
        movie.release_date = "18/03/1997"
        
        vc.movie = movie
        _ = vc.view
        
        XCTAssert(vc.loading.isHidden == false, "loading state failed")
        
        let details = MovieDetails()
        details.title = "Teste"
        details.release_date = "18/03/1997"
        details.vote_average = 7.0
        
        vc.didLoadMovieDetails(details: details)
        XCTAssert(vc.movieView.isHidden == false, "showing state failed")
    }
    
    func testFilterView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Storyboard error")
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MoviesFilterVC") as? MoviesFilterVC else {
            XCTAssert(false, "Can't instantiate MoviesFilterVC")
            return
        }
        
        vc.titleTextField = UITextField()
        vc.filter(self)
        XCTAssert(vc.searchIsValid() == false, "search should be invalid")
        
        vc.titleTextField.text = "teste"
        vc.filter(self)
        XCTAssert(vc.searchIsValid() == true, "search should be valid")
    }
    
    func mockMovies() -> [Movie] {
        var movies: [Movie] = []
        
        let movie1 = Movie()
        movie1.id = 1
        movie1.title = "teste 1"
        movie1.release_date = "18/03/1997"
        movies.append(movie1)
        
        let movie2 = Movie()
        movie2.id = 2
        movie2.title = "teste 2"
        movie2.release_date = "13/03/2001"
        movies.append(movie2)
        
        return movies
    }
    
    func mockFavoriteMovies() -> [FavoriteMovie] {
        var movies: [FavoriteMovie] = []
        
        let movie1 = FavoriteMovie()
        movies.append(movie1)
        
        let movie2 = FavoriteMovie()
        movies.append(movie2)
        
        return movies
    }
    
    
}
