//
//  RecommendedSerieCollectionViewCell.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 10/10/2022.
//

import UIKit

class RecommendedSerieCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageSerie: UIImageView!
    @IBOutlet weak var reviewSerie: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleSerie: UILabel!
    
    var infoRecommandedSerie: Series? {
        didSet{
            let closedRange = 4.0...7.0
            guard let review = infoRecommandedSerie?.voteAverage else { return }
            imageSerie.sd_setImage(with: infoRecommandedSerie?.posterURL)
            reviewSerie.text = String(format: "%.1f", review)
            titleSerie.text = infoRecommandedSerie?.name
            
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
            imageSerie.layer.cornerRadius = 10

        }
    }
}
