//
//  TopRatedSeriesNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 10/10/2022.
//

import Foundation

func getTopRatedSeries(page: String) async -> SerieResponse {
    
    let url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)&language=en-US&page=\(page)")!
    
    let (data,_) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(SerieResponse.self, from: data)
    
    
}
