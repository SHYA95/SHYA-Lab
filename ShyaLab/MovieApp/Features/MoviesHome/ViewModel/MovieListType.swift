//
//  MovieListType.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

// MARK: - View States (Models)

enum MoviesHomeViewState {
    case idle
    case loading
    case success([Movie])
    case failure(String)
    case empty
}

// MARK: - List Type Enum

public enum MovieListType {
    case nowPlaying
    case popular
    case upcoming
    
    var title: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        }
    }
}
