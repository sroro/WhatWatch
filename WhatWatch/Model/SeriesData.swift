//
//  SeriesData.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 08/10/2022.
//

import Foundation


struct Series: Decodable, Equatable, Identifiable {
    
    let id: Int
    let posterPath: String?
    let firstAirDate: String
    let name: String
    let voteAverage: Double
    let overview: String
    
    var posterURL: URL{URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath ?? "" )")!}
}

struct SerieResponse: Decodable {
    let results : [Series]
}

