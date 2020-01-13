//
//  MovieDetailsVC.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 18/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var detailViewHeight: NSLayoutConstraint!
    
    private var movieDetailsViewModel: MovieDetailsViewModel?
    private var isFavorite: Bool = false
    var movie: Movie?
    var showingDetails: Bool = true
    
    @IBOutlet weak var hiddenDetailsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes do filme"
        setupViewState(state: .loading)
        movieDetailsViewModel = MovieDetailsViewModel(delegate: self)
        if let id = self.movie?.id {
            self.movieDetailsViewModel?.loadMovieDetails(movieId: id)
            isFavorite = self.movieDetailsViewModel?.movieIsFavorite(movieId: id) ?? false
            setupFavButton()
        }
    }
    
    func setupFavButton() {
        let btnText = isFavorite ? "Remover dos Favoritos" : "Adicionar aos Favoritos"
        self.favoriteBtn.setTitle(btnText, for: .normal)
    }
    
    private func setupViewState(state: ViewState) {
        self.movieView.isHidden = true
        self.loading.isHidden = true
        
        switch state {
        case .loading:
            self.loading.isHidden = false
            self.loading.startAnimating()
            
        case .showing:
            self.movieView.isHidden = false
            
        default:
            break
        }
    }
    
    @IBAction func favoriteMovie(_ sender: Any) {
        if !isFavorite {
            guard let img = self.movieImage.image else { return }
            movieDetailsViewModel?.saveToFavorites(movieImage: img)
        
        } else {
            self.movieDetailsViewModel?.removeToFavorites()
        }
    }
    
    @IBAction func hiddenDetails(_ sender: Any) {
        let newHeight: CGFloat = showingDetails ? 175 : 400
        let imageName: String = showingDetails ? "arrowTop" : "arrowDown"
        UIView.animate(withDuration: 0.5) {
            self.detailViewHeight.constant = newHeight
            self.view.layoutIfNeeded()
        }
        
        self.hiddenDetailsBtn.setImage(UIImage(named: imageName), for: .normal)
        showingDetails = !showingDetails
        
    }
}

extension MovieDetailsVC: MovieDetailsProtocol {
    func movieFavorited() {
        isFavorite = true
        setupFavButton()
    }
    
    func movieUnfavorited() {
        isFavorite = false
        setupFavButton()
    }
    
    func didLoadMovieDetails(details: MovieDetails) {
        
        if let endpoint = details.backdrop_path {
            let baseImageUrl = "https://image.tmdb.org/t/p/w300/\(endpoint)"
            if let url = URL(string: baseImageUrl) {
                self.movieImage.downloaded(url: url)
            }
        }
        
        self.movieTitle.text = details.title
        self.movieDescription.text = details.overview
        self.movieRate.text = details.tagline
        
        if let date = details.release_date {
            self.movieDate.text = "Estreia: \(date)"
        }
        
        setupViewState(state: .showing)
    }
    
    func didFailedLoadMovieDetails() {
        let alert = UIAlertController(title: "Atenção", message: "Erro ao carregar as informações do filme", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Tentar Novamente", style: .default, handler: { (action) in
            if let id = self.movie?.id {
                self.movieDetailsViewModel?.loadMovieDetails(movieId: id)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
