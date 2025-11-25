//
//  MoviesRepositoryProtocol.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getNowPlayingMovies() async throws -> [Movie]
    func getPopularMovies() async throws -> [Movie]
    func getUpcomingMovies() async throws -> [Movie]
    func getMovieDetails(id: Int) async throws -> Movie
}
