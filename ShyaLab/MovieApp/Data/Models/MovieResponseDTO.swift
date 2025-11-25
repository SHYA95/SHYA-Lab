//
//  MovieResponseDTO.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

struct MovieResponseDTO: Codable {
    let page: Int
    let results: [MovieDTO]
}

