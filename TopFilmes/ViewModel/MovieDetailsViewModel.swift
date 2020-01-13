//
//  MovieDetailsViewModel.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 18/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol MovieDetailsProtocol {
    func didLoadMovieDetails(details: MovieDetails)
    func didFailedLoadMovieDetails()
    func movieFavorited()
    func movieUnfavorited()
}

class MovieDetailsViewModel {
    var delegate: MovieDetailsProtocol
    var movie: MovieDetails?
    
    private let service = MoviesService()
    
    init(delegate: MovieDetailsProtocol) {
        self.delegate = delegate
    }
    
    public func loadMovieDetails(movieId: Int) {
        service.getMovieDetails(movieId: movieId) { (response) in
            if response.error != nil {
                self.delegate.didFailedLoadMovieDetails()
                
            } else {
                if let details = response.result.value {
                    self.movie = details
                    self.delegate.didLoadMovieDetails(details: details)
                }
            }
        }
    }
    
    func saveToFavorites(movieImage: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let movieId = self.movie?.id else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let favMovie = NSEntityDescription
            .insertNewObject(forEntityName: "FavoriteMovie",
                             into: managedContext) as? FavoriteMovie else {
            return
        }
        
        favMovie.id = String(movieId)
        favMovie.title = movie?.title
        favMovie.date = movie?.release_date
        favMovie.image = movieImage.pngData()
        
        do {
            try managedContext.save()
        } catch {
            print("Failure to save context: \(error)")
        }
        managedContext.refreshAllObjects()
        self.delegate.movieFavorited()
    }
    
    func removeToFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let movieId = self.movie?.id else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "id = %@", String(movieId))
        
        do {
            let result: [NSManagedObject] = try managedContext.fetch(request) as! [NSManagedObject]
            for item in result {
                managedContext.delete(item)
            }
            try managedContext.save()
            
        } catch {
            print("Failed to remove movie")
        }
        managedContext.refreshAllObjects()
        self.delegate.movieUnfavorited()
    }
    
    func movieIsFavorite(movieId: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "id = %@", String(movieId))
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                return true
            } else {
                return false
            }
            
        } catch {
            return false
        }
    }
}
