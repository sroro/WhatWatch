//
//  MovieDataNetWork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 02/10/2022.
//

import Foundation

func getMovieOfWeek(page: String) async  -> MovieResponse {
    
    let url = URL(string:"https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)&page=\(page)&language=fr")!
    
    let (data,_) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(MovieResponse.self, from: data)
    
}
    
