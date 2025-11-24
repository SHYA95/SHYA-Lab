//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//
import Foundation

class MoviesRepository: MoviesRepositoryProtocol {
    
   private let apiClient: APIClient<MoviesEndpoint>
    
    init(apiClient: APIClient<MoviesEndpoint> = APIClient<MoviesEndpoint>()) {
        self.apiClient = apiClient
    }
    
    func getNowPlayingMovies() async throws -> [Movie] {
        let response: MovieResponseDTO = try await apiClient.performRequest(target: .nowPlaying)
        return response.results.map { $0.toDomain() }
    }
    
    func getPopularMovies() async throws -> [Movie] {
        let response: MovieResponseDTO = try await apiClient.performRequest(target: .popular)
        return response.results.map { $0.toDomain() }
    }
    
    func getUpcomingMovies() async throws -> [Movie] {
        let response: MovieResponseDTO = try await apiClient.performRequest(target: .upcoming)
        return response.results.map { $0.toDomain() }
    }
    
    func getMovieDetails(id: Int) async throws -> Movie {
        let dto: MovieDTO = try await apiClient.performRequest(target: .details(id: id))
        return dto.toDomain()
    }
}
