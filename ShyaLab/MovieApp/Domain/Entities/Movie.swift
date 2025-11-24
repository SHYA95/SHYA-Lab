//
//  Movie.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let releaseDate: String
    let rating: String
    let genres: [String]?
}
