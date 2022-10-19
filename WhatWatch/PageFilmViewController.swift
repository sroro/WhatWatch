//
//  PageFilmViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 06/10/2022.
//

import UIKit

class PageFilmViewController: UIViewController {
    
    //MARK: - Outlets
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var overviewMovie: UITextView!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var dateSortie: UILabel!
    //MARK: - Outlets
    
    var coreDataManager: CoreDataManager?
    var infosMovie = [Movie]()
    var arrayMovieRecommanded = [Movie]()
    var arrayMovie =  [Result]()
    var idMovieSelected = Int()
    var titleMovieSelected = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        collectionView.register(UINib(nibName: "RecommandedMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "otherMovieCell")
        addInfoMovie()
        getMovieRecommanded()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleMovieSelected = infosMovie[0].title
        // garder l'icone rempli quand le film est en favoris
        if coreDataManager?.isRegistered(title: titleMovieSelected) == true {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    
    // MARK: - IbActions
    
    @IBAction func FavoriteBarButton(_ sender: UIBarButtonItem) {
          
        switch coreDataManager?.isRegistered(title: titleMovieSelected) {
        case true:
            coreDataManager?.deleteMedia(title: titleMovieSelected)
            favoriteButton.image = UIImage(systemName: "heart")
        case false:
            
            favoriteButton.image = UIImage(systemName: "heart.fill")
            coreDataManager?.createMedia(title: infosMovie[0].title, id: Double(infosMovie[0].id), review: infosMovie[0].voteAverage, image: infosMovie[0].posterURl, overview: infosMovie[0].overview, date: infosMovie[0].releaseDate)
            
        default: break
        }
    }

    
    @IBAction func returnButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func youtubeButton(_ sender: Any) {
        
        Task {
            arrayMovie =  await getVideoMovie(id: idMovieSelected).results
            if arrayMovie.isEmpty {
                AlertNoExtrait()
            } else {
                //recuperer la clé du film pour l'ajouter a l'url youtube
                let key = arrayMovie[0].key
                let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                
                _ =  await UIApplication.shared.open(youtubeURL)
            }
        }
    }
    
    
    
   
    
    //MARK: - Methods
    
    // appel reseau des films recommandé pour le film cliqué
    func getMovieRecommanded() {
        idMovieSelected = infosMovie[0].id
        Task{
            arrayMovieRecommanded = await getRecommandedMovie(movieId: idMovieSelected).results
            collectionView.reloadData()
        }
        
    }
    
    // rempli les informations du film cliqué
    func addInfoMovie() {
        navigationItem.title = infosMovie[0].title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        overviewMovie.text = infosMovie[0].overview
        imageMovie.sd_setImage(with: infosMovie[0].posterURl)
        review.text = String(format: "%.1f", infosMovie[0].voteAverage)
        dateSortie.text = infosMovie[0].releaseDate
        
    }
    
}

extension PageFilmViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherMovieCell", for: indexPath) as? RecommandedMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.infosRecommandedMovie = arrayMovieRecommanded[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMovieRecommanded.count
    }
    
    
}
