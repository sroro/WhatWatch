//
//  PopularSerieNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 08/10/2022.
//

import Foundation

func getSeriePopular(page: String) async -> SerieResponse {
    
    let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=fr&page=\(page)")!
    
    let (data,_) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(SerieResponse.self, from: data)
}
