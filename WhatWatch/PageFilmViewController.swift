//
//  PageFilmViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 06/10/2022.
//

import UIKit

class PageFilmViewController: UIViewController {


    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var overviewMovie: UITextView!
    @IBOutlet weak var addFavorite: UIButton!
    @IBOutlet weak var review: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "RecommandedMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "otherMovieCell")
        navigationItem.title = infosMovie[0].title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        overviewMovie.text = infosMovie[0].overview
        imageMovie.sd_setImage(with: infosMovie[0].posterURl)
        review.text = String(infosMovie[0].voteAverage)
       
        getMovieRecommanded()
 
    }
    
    
    // MARK: - IbActions
    @IBAction func addFavorite(_ sender: Any) {
        print("hello")
        favoriteButton.imageView?.image = UIImage(named: "heart.fill")
        
    }
    
    
    @IBAction func youtubeButton(_ sender: Any) {
      
        Task {
           arrayMovie =  await getVideoMovie(id: idMovie).results
            if arrayMovie.isEmpty {
                print("empty")
            } else {
                var key = arrayMovie[0].key
                var youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                print(youtubeURL)
               await UIApplication.shared.open(youtubeURL)
            }
        }
        
        
        
    }
      
        
    
    //MARK: - Outlets
    
    
    var infosMovie = [Movie]()
    var arrayMovieRecommanded = [Movie]()
    var arrayMovie =  [Result]()
    var idMovie = Int()
    
    
    //MARK: - Methods
    
    
    func getMovieRecommanded() {
        idMovie = infosMovie[0].id
        Task{
            arrayMovieRecommanded = await getRecommandedMovie(movieId: idMovie).results
            collectionView.reloadData()
        }
       
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
