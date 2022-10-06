//
//  ViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 01/10/2022.
//

import UIKit

class MovieWeekViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")

        callMovie()
    }
    
    
    // MARK: - Outlet
    
    
    var indexSegmentedControl = Int()
    
    // permet de recevoir les 10 pages de l'api TMDB
    var pages = ["1","2","3","4","5","6","7","8","9","10"]
    var arrayMovieSelected  : [Movie] = []
    var movies : [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func segmentedControlButton(_ sender: Any) {
        
        indexSegmentedControl = segmentControl.selectedSegmentIndex
        
        if indexSegmentedControl == 0 {
            movies.removeAll()
            callMovie()
        } else if indexSegmentedControl == 1 {
            callTopRatedMovie()
            movies.removeAll()
        } else {
            callUpcomingMovie()
            movies.removeAll()
        }
        
    }
    
    //MARK: Methods
    
    func callMovie() {
        Task{
            for test in pages{
                await movies.append(contentsOf: getMovieOfWeek(page: test).results)
            }
        }
    }
    
    func callTopRatedMovie() {
        Task{
            movies = await getTopRatedMovie().results
        }
    }
    
    func callUpcomingMovie() {
        Task{
            movies = await getMovieUpcoming().results
        }
    }
    
}

extension MovieWeekViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.infoMovie = movies[indexPath.row]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrayMovieSelected.removeAll()
        arrayMovieSelected.append(movies[indexPath.row])
        performSegue(withIdentifier: "segueToMovie", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToMovie" {
            let vcDestination = segue.destination as? PageFilmViewController
            vcDestination?.infosMovie = arrayMovieSelected
         
        }
    }
    
    
    
}

