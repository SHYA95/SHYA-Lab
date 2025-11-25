//
//  MoviesUseCases.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

// MARK: - Use Cases
protocol FetchMoviesUseCase {
    func execute() async throws -> [Movie]
}

struct GetNowPlayingMoviesUseCase: FetchMoviesUseCase {
    private let repository: MoviesRepositoryProtocol
    
    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [Movie] {
        return try await repository.getNowPlayingMovies()
    }
}



