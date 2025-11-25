//
//  HomeViewModel.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import Foundation
import Combine

// MARK: - Protocol
protocol MoviesHomeViewModelProtocol: AnyObject {
    // Outputs
    var title: String { get }
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }
    var moviesPublisher: AnyPublisher<[Movie], Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    
    // Inputs
    func loadMovies()
}

// MARK: - ViewModel Implementation
class MoviesHomeViewModel: MoviesHomeViewModelProtocol {
    
    // MARK: - Private Properties
    @Published private var state: MoviesHomeViewState = .idle
    private let useCase: FetchMoviesUseCase
    private let screenTitle: String
    
    // MARK: - Init
    init(title: String, useCase: FetchMoviesUseCase) {
        self.screenTitle = title
        self.useCase = useCase
    }
    
    // MARK: - Outputs (Logic Moved Here)
    
    var title: String {
        return screenTitle
    }
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        $state
            .map { state in
                if case .loading = state { return true }
                return false
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var moviesPublisher: AnyPublisher<[Movie], Never> {
        $state
            .compactMap { state -> [Movie]? in
                if case .success(let movies) = state { return movies }
                if case .empty = state { return [] }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        $state
            .compactMap { state -> String? in
                if case .failure(let message) = state { return message }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Inputs
    
    func loadMovies() {
        state = .loading
      
        Task { @MainActor in
            do {
                let movies = try await useCase.execute()
                state = movies.isEmpty ? .empty : .success(movies)
                
            } catch let error as AppErrorType {
                state = .failure(error.message)
            } catch {
                state = .failure("An unexpected error occurred.")
            }
        }
    }
}
