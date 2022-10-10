//
//  VideoMovieNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 07/10/2022.
//

import Foundation

func getVideoMovie(id: Int) async -> Video {
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=7cbac0fdc9b3acf0f187865ced8582aa&language=fr")!
    
    let (data,_) = try! await URLSession.shared.data(from: url)
    
    return try! JSONDecoder().decode(Video.self, from: data)
}
