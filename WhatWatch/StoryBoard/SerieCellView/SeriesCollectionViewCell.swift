//
//  SeriesCollectionViewCell.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 08/10/2022.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var imageSerie: UIImageView!
    @IBOutlet weak var titleSerie: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var reviewSerie: UILabel!
    
    var infoSerie: Series? {
        didSet{
            guard let review = infoSerie?.voteAverage else { return }
            let closedRange = 4.0...7.0
            imageSerie.sd_setImage(with: infoSerie?.posterURL)
            titleSerie.text = infoSerie?.name
            releaseDate.text = infoSerie?.firstAirDate
            reviewSerie.text = String(format: "%.1f", review)
            viewCell.layer.cornerRadius = 10
            imageSerie.layer.cornerRadius = 10
            
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
