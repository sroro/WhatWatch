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
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var infosRecommandedMovie: Movie? {
        didSet{
            guard let review = infosRecommandedMovie?.voteAverage else { return }
            let closedRange = 4.0...7.0
            
            reviewLabel.text = String(format: "%.1f", review)
            titleMovie.text = infosRecommandedMovie?.title
            imageMovie.sd_setImage(with: infosRecommandedMovie?.posterURl)
            
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

        }
        
    }
}
