//
//  PageSerieViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 10/10/2022.
//

import UIKit

class PageSerieViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        fillSerieInfo()
        getSerieRecommendation()
        collectionView.register(UINib(nibName: "RecommendedSerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "recommandedSerieCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleSerieSelected = infoSerie[0].name
        
        if coreDataManager?.isRegistered(title: titleSerieSelected) == true {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    //MARK: - Outlets
    
    
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageSerie: UIImageView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var serieReview: UILabel!
    @IBOutlet weak var dateSortie: UILabel!
    
    
    //MARK: -Properties
    var coreDataManager: CoreDataManager?
    var arrayVideoSerie = [Result]()
    var infoSerie = [Series]()
    var arraySeriesRecommanded = [Series]()
    var idSerieSelected = Int()
    var titleSerieSelected = String()
    
    //MARK: -IBActions
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addFavorite(_ sender: Any ) {
        
        switch coreDataManager?.isRegistered(title: titleSerieSelected) {
        case true:
            coreDataManager?.deleteMedia(title: titleSerieSelected)
            favoriteButton.image = UIImage(systemName: "heart")
        case false:
            
            favoriteButton.image = UIImage(systemName: "heart.fill")
            coreDataManager?.createMedia(title: infoSerie[0].name, id: Double(infoSerie[0].id), review: infoSerie[0].voteAverage, image: infoSerie[0].posterURL, overview: infoSerie[0].overview, date: infoSerie[0].firstAirDate)
            
        default: break
        }
    }
    
    @IBAction func youtubeButton(_ sender: Any) {
        Task {
            arrayVideoSerie =  await getVideo(id: idSerieSelected).results
            if arrayVideoSerie.isEmpty {
                AlertNoExtrait()
            } else {
                let key = arrayVideoSerie[0].key
                let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                _ =  await UIApplication.shared.open(youtubeURL)
            }
        }
    }
    
    
    
    //MARK: - Methods
    
    func fillSerieInfo() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = infoSerie[0].name
        imageSerie.sd_setImage(with: infoSerie[0].posterURL)
        overview.text = infoSerie[0].overview
        serieReview.text = String(format: "%.1f", infoSerie[0].voteAverage)
        
    }
    
    func getSerieRecommendation() {
        idSerieSelected = infoSerie[0].id
        Task{
            arraySeriesRecommanded = await getRecommendationSerie(id: idSerieSelected).results
            collectionView.reloadData()
        }
    }
}



extension PageSerieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySeriesRecommanded.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommandedSerieCell", for: indexPath) as? RecommendedSerieCollectionViewCell else { return UICollectionViewCell()}
        cell.infoRecommandedSerie = arraySeriesRecommanded[indexPath.row]
        return cell
    }
    
    
}


