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
        titleSerie = infoSerie[0].name
        
        if coreDataManager?.isRegistered(title: titleSerie) == true {
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
    var arraySeriesRecommaned = [Series]()
    var idSerie = Int()
    var titleSerie = String()
    
    //MARK: -IBActions
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func addFavorite(_ sender: Any ) {
       
        
        switch coreDataManager?.isRegistered(title: titleSerie) {
        case true:
            coreDataManager?.deleteMedia(title: titleSerie)
            favoriteButton.image = UIImage(systemName: "heart")
        case false:
            
            favoriteButton.image = UIImage(systemName: "heart.fill")
            coreDataManager?.createMedia(title: infoSerie[0].name, id: Double(infoSerie[0].id), review: infoSerie[0].voteAverage, image: infoSerie[0].posterURL, overview: infoSerie[0].overview, date: infoSerie[0].firstAirDate)
            
        default: break
        }
    }
    
    @IBAction func youtubeButton(_ sender: Any) {
        Task {
            arrayVideoSerie =  await getVideo(id: idSerie).results
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
        idSerie = infoSerie[0].id
        Task{
            arraySeriesRecommaned = await getRecommendationSerie(id: idSerie).results
            collectionView.reloadData()
        }
    }
    
    func getVideoSerie() {
        
       
        
    }
}



extension PageSerieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySeriesRecommaned.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommandedSerieCell", for: indexPath) as? RecommendedSerieCollectionViewCell else { return UICollectionViewCell()}
        cell.infoRecommandedSerie = arraySeriesRecommaned[indexPath.row]
        return cell
    }
    
    
}


