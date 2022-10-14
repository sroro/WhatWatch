//
//  FavoriteMediaViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 13/10/2022.
//

import UIKit

class FavoriteMediaViewController: UIViewController {

    var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "SeriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serieCell")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        collectionView.reloadData()
        print(coreDataManager?.medias.count ?? [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
 
    @IBAction func deleteAll(_ sender: Any) {
        coreDataManager?.deleteAllMedia()
        collectionView.reloadData()
    }
    
}

extension FavoriteMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coreDataManager?.medias.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serieCell", for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell()}
        cell.infoFavorite = coreDataManager?.medias[indexPath.row]
        return cell
    }
    
    
}
