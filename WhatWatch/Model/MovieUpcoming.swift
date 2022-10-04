//
//  MovieUpcoming.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 03/10/2022.
//

import Foundation

func getMovieUpcoming() async ->  MovieResponse {
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en&page=1&page=20" )!
    let (data,_) = try! await URLSession.shared.data(from: url)
    return try! jsonDecoder.decode(MovieResponse.self, from: data)
    
}
