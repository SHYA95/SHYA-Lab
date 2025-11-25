//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//
import Foundation

class MoviesRepository: MoviesRepositoryProtocol {
    
    // MARK: - Properties
    
    private let apiClient: APIClient<MoviesEndpoint>
    private let localDataSource: MovieLocalDataSource
    
    // MARK: - Initialization
    
    init(apiClient: APIClient<MoviesEndpoint> = APIClient<MoviesEndpoint>(),
         localDataSource: MovieLocalDataSource = MovieLocalDataSource()) {
        self.apiClient = apiClient
        self.localDataSource = localDataSource
    }
    
    // MARK: - Now Playing
    
    func getNowPlayingMovies() async throws -> [Movie] {
        do {
            let response: MovieResponseDTO = try await apiClient.performRequest(target: .nowPlaying)
            localDataSource.saveMovies(response.results, key: .nowPlaying)
            return response.results.map { $0.toDomain() }
        } catch {
            print("🌐 Network failed for Now Playing. Checking Cache...")
            if let cachedMovies = localDataSource.getMovies(key: .nowPlaying) {
                return cachedMovies.map { $0.toDomain() }
            }
            throw error
        }
    }
    
    // MARK: - Popular
    
    func getPopularMovies() async throws -> [Movie] {
        do {
            let response: MovieResponseDTO = try await apiClient.performRequest(target: .popular)
            localDataSource.saveMovies(response.results, key: .popular)
            return response.results.map { $0.toDomain() }
        } catch {
            print("🌐 Network failed for Popular. Checking Cache...")
            if let cachedMovies = localDataSource.getMovies(key: .popular) {
                return cachedMovies.map { $0.toDomain() }
            }
            throw error
        }
    }
    
    // MARK: - Upcoming
    
    func getUpcomingMovies() async throws -> [Movie] {
        do {
            let response: MovieResponseDTO = try await apiClient.performRequest(target: .upcoming)
            localDataSource.saveMovies(response.results, key: .upcoming)
            return response.results.map { $0.toDomain() }
        } catch {
            print("🌐 Network failed for Upcoming. Checking Cache...")
            if let cachedMovies = localDataSource.getMovies(key: .upcoming) {
                return cachedMovies.map { $0.toDomain() }
            }
            throw error
        }
    }
    
    // MARK: - Movie Details
    
    func getMovieDetails(id: Int) async throws -> Movie {
        let dto: MovieDTO = try await apiClient.performRequest(target: .details(id: id))
        return dto.toDomain()
    }
}
