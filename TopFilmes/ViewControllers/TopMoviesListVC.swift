//
//  TopMoviesListVC.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 17/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import UIKit

class TopMoviesListVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    private var topMoviesListViewModel: TopMoviesListViewModel?
    private var page: Int = 1
    private var filter: MoviesFilter?
    private var refreshControl = UIRefreshControl()
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Filmes"
        self.setupViewState(state: .loading)
        self.topMoviesListViewModel = TopMoviesListViewModel(delegate: self)
        self.topMoviesListViewModel?.loadTopMovies(page: page)
        self.setupCollectionView()
        self.loadRefresh()
    }
    
    func setupViewState(state: ViewState) {
        self.collectionView.isHidden = true
        self.loading.isHidden = true
        self.emptyLabel.isHidden = true
        self.tryAgainBtn.isHidden = true
        
        
        switch state {
        case .loading:
            self.loading.isHidden = false
            self.loading.startAnimating()
            
        case .showing:
            self.collectionView.isHidden = false
            
        case .empty:
            self.emptyLabel.isHidden = false
            self.emptyLabel.text = "Nenhum resultado encontrado"
            
        case .error:
            self.emptyLabel.text = "Erro ao processar sua solicitação"
            self.emptyLabel.isHidden = false
            self.tryAgainBtn.isHidden = false
            
        }
        self.view.layoutIfNeeded()
    }
    
    private func loadRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self,
                                      action: #selector(refresh),
                                      for: UIControl.Event.valueChanged)
        self.collectionView.addSubview(refreshControl)
    }
    
    @objc
    func refresh(sender: AnyObject) {
        self.setupViewState(state: .loading)
        self.movies = []
        self.page = 1
        self.filter = nil
        self.topMoviesListViewModel?.loadTopMovies(page: page)
        refreshControl.endRefreshing()
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
    
    @IBAction func showFilterView(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesFilterVC") as! MoviesFilterVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        self.setupViewState(state: .loading)
        self.topMoviesListViewModel?.loadTopMovies(page: page)
    }
}

extension TopMoviesListVC: TopMoviesListProtocol {
    func didLoadMovies(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        if movies.count > 0 {
            self.collectionView.reloadData()
            setupViewState(state: .showing)
        } else {
            setupViewState(state: .empty)
        }
    }
    
    func didFailedLoadMovies() {
        setupViewState(state: .error)
    }
}

extension TopMoviesListVC: MoviesFilterProtocol {
    func filterMovies(filter: MoviesFilter) {
        self.setupViewState(state: .loading)
        self.movies = []
        self.page = 1
        self.filter = filter
        self.topMoviesListViewModel?.loadMoviesFromFilter(filter: filter,
                                                          page: self.page)
    }
}

extension TopMoviesListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setupCell(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            page += 1
            
            if self.filter == nil {
                self.topMoviesListViewModel?.loadTopMovies(page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
