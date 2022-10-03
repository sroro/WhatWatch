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
        collectionView.delegate = self
        callMovie()
    }
    
    var movies : [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    func callMovie() {
        Task{
            movies = await getMovieOfWeek().results
            await print(getMovieOfWeek().results)
        }
    }

}

extension MovieWeekViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.infoMovie = movies[indexPath.row]
        return cell
    }
    
    
    
    
}

