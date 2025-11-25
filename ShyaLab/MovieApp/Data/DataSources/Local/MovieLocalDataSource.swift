//
//  MovieLocalDataSource.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

class MovieLocalDataSource {
    
    // MARK: - Constants
    
    enum CacheKey: String {
        case nowPlaying = "now_playing_cache"
        case popular = "popular_cache"
        case upcoming = "upcoming_cache"
    }
    
    // MARK: - Properties
    
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: - Public Methods
    
    /// Saves a list of MovieDTOs to the file system
    func saveMovies(_ movies: [MovieDTO], key: CacheKey) {
        guard let url = getFileURL(for: key) else { return }
        
        do {
            let data = try encoder.encode(movies)
            try data.write(to: url)
            print("💾 [Cache] Saved successfully for key: \(key.rawValue)")
        } catch {
            print("❌ [Cache] Failed to save for key \(key.rawValue): \(error)")
        }
    }
    
    /// Retrieves a list of MovieDTOs from the file system
    func getMovies(key: CacheKey) -> [MovieDTO]? {
        guard let url = getFileURL(for: key) else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let movies = try decoder.decode([MovieDTO].self, from: data)
            print("📂 [Cache] Loaded successfully for key: \(key.rawValue)")
            return movies
        } catch {
            print("⚠️ [Cache] No data found or failed to decode for key \(key.rawValue)")
            return nil
        }
    }
    
    // MARK: - Private Helpers
    
    private func getFileURL(for key: CacheKey) -> URL? {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent("\(key.rawValue).json")
    }
}
