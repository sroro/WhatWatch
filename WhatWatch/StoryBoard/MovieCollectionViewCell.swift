//
//  MovieCollectionViewCell.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 01/10/2022.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var reviewMovie: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var infoMovie: Movie? {
        didSet{
            guard let review = infoMovie?.voteAverage else { return }
            let closedRange = 4.0...7.0
            titleMovie.text = infoMovie?.title
            reviewMovie.text = String(review)
            dateMovie.text = infoMovie?.releaseDate
            imageMovie.sd_setImage(with: infoMovie?.posterURl)
            
            if review <= 4.5 {
                progressView.progressTintColor = .red
                progressView.progress = Float(review/10)
            } else if closedRange.contains(review) {
                progressView.progressTintColor = .orange
                progressView.progress = Float(review/10)
            } else {
                progressView.progressTintColor = .green
                progressView.progress = Float(review/10)

            }
            
            view.layer.cornerRadius = 10
            imageMovie.layer.cornerRadius = 10
            
            
        }
    }
    
  

}
