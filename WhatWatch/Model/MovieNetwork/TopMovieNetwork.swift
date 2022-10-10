//
//  TopMovieNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 03/10/2022.
//

import Foundation

func getTopRatedMovie(page:String) async -> MovieResponse {
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=fr&page=\(page)")!
    
    let (data,_) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(MovieResponse.self, from: data )
}
