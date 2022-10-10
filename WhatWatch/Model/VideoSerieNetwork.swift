//
//  VideoSerieNetwork.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 10/10/2022.
//

import Foundation


func getVideo(id:Int) async -> Video {
    let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)/videos?api_key=\(apiKey)&language=fr")!
    let (data,_) = try! await URLSession.shared.data(from: url)
    return try! JSONDecoder().decode(Video.self, from: data)
}
