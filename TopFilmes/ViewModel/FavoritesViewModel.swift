//
//  FavoritesViewModel.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 19/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol FavoritesProtocol {
    func didLoadMovies(favoriteMovies: [FavoriteMovie])
}

class FavoritesViewModel {
    var delegate: FavoritesProtocol
    private let service = MoviesService()
    
    init(delegate: FavoritesProtocol) {
        self.delegate = delegate
    }
    
    public func loadFavoriteMovies() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        
        do {
            let result = try managedContext.fetch(request) as! [FavoriteMovie]
            self.delegate.didLoadMovies(favoriteMovies: result)
            
        } catch {
               print("Failed to load movie")
        }
    }
}
