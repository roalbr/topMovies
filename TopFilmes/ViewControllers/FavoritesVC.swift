//
//  FavoritesVC.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 19/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private var favoritesViewModel: FavoritesViewModel?
    private var favoriteMovies: [FavoriteMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filmes Favoritos"
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesViewModel = FavoritesViewModel(delegate: self)
        self.favoritesViewModel?.loadFavoriteMovies()
    }
    
     func setupViewState(state: ViewState) {
        self.collectionView.isHidden = true
        self.emptyLabel.isHidden = true
        
        switch state {
        case .showing:
            self.collectionView.isHidden = false
            
        case .empty:
            self.emptyLabel.isHidden = false
            self.emptyLabel.text = "Você não tem favoritos"
            
        default:
            break
            
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil),
                                forCellWithReuseIdentifier: "MovieCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.layoutCells()
    }
    
    private func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        
        let width: CGFloat = (UIScreen.main.bounds.width - 16) / 3
        let height: CGFloat = (UIScreen.main.bounds.height - 16) / 2.5
        
        layout.itemSize = CGSize(width: width,
                                 height: height)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
}

extension FavoritesVC: FavoritesProtocol {
    func didLoadMovies(favoriteMovies: [FavoriteMovie]) {
        self.favoriteMovies = favoriteMovies
        if favoriteMovies.count > 0 {
            self.collectionView.reloadData()
            setupViewState(state: .showing)
        } else {
            setupViewState(state: .empty)
        }
    }
}

extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteMovie = self.favoriteMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setupCell(favoriteMovie: favoriteMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favoriteMovie = self.favoriteMovies[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movie = loadMovieModel(favorite: favoriteMovie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loadMovieModel(favorite: FavoriteMovie) -> Movie {
        let movie = Movie()
        movie.id = Int(favorite.id ?? "")
        return movie
    }
}
