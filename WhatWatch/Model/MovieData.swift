//
//  MovieData.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 02/10/2022.
//

import Foundation

let apiKey = "7cbac0fdc9b3acf0f187865ced8582aa"

struct Movie: Decodable, Equatable, Identifiable {
    
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPath: String
    let releaseDate: String
    var posterURl: URL { URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")!}
    
   
}

struct MovieResponse: Decodable {
    let results : [Movie]
}

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

