//
//  RecommandedMovieNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 06/10/2022.
//

import Foundation


func getRecommandedMovie(movieId: Int) async -> MovieResponse {
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?api_key=\(apiKey)&language=en-US&page=1")!
    let (data,_) = try! await URLSession.shared.data(from: url)
    return try! jsonDecoder.decode(MovieResponse.self, from: data)
}
