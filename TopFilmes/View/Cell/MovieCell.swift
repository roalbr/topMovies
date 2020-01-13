//
//  MovieCell.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 17/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var detailsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.movieImage.image = UIImage(named: "placeholder")
        self.movieTitle.text = ""
        self.movieYear.text = ""
        super.prepareForReuse()
    }
    
    func setupCell(movie: Movie) {
        self.movieTitle.text = movie.title
        self.movieYear.text = movie.release_date
        self.loadMovieImage(imagePath: movie.backdrop_path)
    }
    
    func setupCell(favoriteMovie: FavoriteMovie) {
        self.movieTitle.text = favoriteMovie.title
        self.movieYear.text = favoriteMovie.date
        
        if let imgData = favoriteMovie.image {
            let image = UIImage(data: imgData)
            self.movieImage.image = image
        }
    }
    
    private func loadMovieImage(imagePath: String?) {
        guard let endPoint = imagePath else {
            return
        }
        let baseImageUrl = "https://image.tmdb.org/t/p/w185/\(endPoint)"
        if let url = URL(string: baseImageUrl) {
            movieImage.downloaded(url: url)
        }
    }
}




