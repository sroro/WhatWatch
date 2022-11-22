//
//  FavoriteselectedViewController.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 22/11/2022.
//

import UIKit
import CoreData

class FavoriteSelectedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fillSlected()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    // rempli les info du film favoris selectionné
    var favoriteSelected = [InfoMedia]()
    
    @IBAction func favoriteButton(_ sender: Any) {
       
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func youtubeButton(_ sender: Any) {
    }
    
    func fillSlected() {
        navigationItem.title = favoriteSelected[0].title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        date.text = favoriteSelected[0].date
        image.sd_setImage(with: favoriteSelected[0].image)
        overview.text = favoriteSelected[0].overview
        note.text = String(format: "%.1f", favoriteSelected[0].review)
        
        

    }
}
