//
//  SeriesViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 08/10/2022.
//

import UIKit

class SeriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "SeriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serieCell")
        getPopularSerie()
    }
    
    var numberOfPageAPI = ["1","2","3","4","5","6","7","8","9"]
    var indexSegmentedControl = Int()
    var arraySerieSelected  : [Series] = []
    var series : [Series] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    @IBAction func segmentedControl(_ sender: Any) {
        
        indexSegmentedControl = segmentedControl.selectedSegmentIndex
        
        if indexSegmentedControl == 0 {
            series.removeAll()
            getPopularSerie()
        } else if indexSegmentedControl == 1 {
            series.removeAll()
            getTopRatedSerie()
        }
    }
    
    func getPopularSerie() {
        Task{
            for page in numberOfPageAPI {
                await series.append(contentsOf: getSeriePopular(page: page).results)
            }
            
        }
    }
    
    func getTopRatedSerie(){
        Task{
            for page in numberOfPageAPI {
                await series.append(contentsOf: getTopRatedSeries(page: page).results)
            }
        }
    }
    
}

extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serieCell", for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell()}
        
        cell.infoSerie = series[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        arraySerieSelected.removeAll()
        arraySerieSelected.append(series[indexPath.row])
        performSegue(withIdentifier: "segueToSerie", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSerie" {
            let vcDestination = segue.destination as? PageSerieViewController
            vcDestination?.infoSerie = arraySerieSelected
        }
    }
    
    
}
