//
//  MovieDataVideo.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 07/10/2022.
//

import Foundation

// MARK: - MovieVideo
struct Video: Decodable {
    let id: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let name, key: String
    
    let size: Int
    let type: String
    let official: Bool
    let id: String

    enum CodingKeys: String, CodingKey {
 
        case name, key
        case size, type, official, id
    }
}
