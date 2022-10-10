//
//  RecommendationSerieNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 10/10/2022.
//

import Foundation

func getRecommendationSerie(id: Int) async -> SerieResponse {
    
    let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)/recommendations?api_key=\(apiKey)&language=fr&page=1")!
    
    let (data,_) =  try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(SerieResponse.self, from: data)
    
}
