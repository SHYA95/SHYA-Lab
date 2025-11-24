//
//  MovieDTO.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

struct MovieDTO: Decodable, DomainConvertible {
    let id: Int
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let genres: [GenreDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    func toDomain() -> Movie {
        let fullPosterPath = posterPath != nil ? Constant.imageBaseURL + posterPath! : nil
        
        return Movie(
            id: id,
            title: title ?? "Unknown Movie",
            overview: overview ?? "No overview available.",
            posterURL: URL(string: fullPosterPath ?? ""),
            releaseDate: releaseDate ?? "N/A",
            rating: String(format: "%.1f ⭐️", voteAverage ?? 0.0),
            genres: genres?.compactMap { $0.name }
        )
    }
}
