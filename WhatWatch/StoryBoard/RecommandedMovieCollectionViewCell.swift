//
//  CollectionViewCell.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 06/10/2022.
//

import UIKit

class RecommandedMovieCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 10
        imageMovie.layer.cornerRadius = 10
    }

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    
    var infosRecommandedMovie: Movie? {
        didSet{
          
            titleMovie.text = infosRecommandedMovie?.title
            imageMovie.sd_setImage(with: infosRecommandedMovie?.posterURl)
        }
        
    }
}
