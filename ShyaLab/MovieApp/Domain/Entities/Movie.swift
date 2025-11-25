//
//  Movie.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

struct Movie: Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let releaseDate: String
    let rating: String
    let genres: [String]?
    
    // MARK: - Hashable & Equatable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
