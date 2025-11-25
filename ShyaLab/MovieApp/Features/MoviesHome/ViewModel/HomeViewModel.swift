//
//  HomeViewModel.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import Foundation
import Combine

protocol MoviesHomeViewModelProtocol: AnyObject {
    var state: MoviesHomeViewState { get }
    var statePublisher: AnyPublisher<MoviesHomeViewState, Never> { get }
    var title: String { get }
    func loadMovies()
}

class MoviesHomeViewModel: MoviesHomeViewModelProtocol {
    
    // MARK: - Properties
    @Published var state: MoviesHomeViewState = .idle
    
    private let useCase: FetchMoviesUseCase
    private let screenTitle: String
    
    // MARK: - Outputs
    var statePublisher: AnyPublisher<MoviesHomeViewState, Never> {
        $state.eraseToAnyPublisher()
    }
    
    var title: String {
        screenTitle
    }
    
    // MARK: - Init
    // We inject the UseCase directly. The VM doesn't know about Repositories anymore.
    init(title: String, useCase: FetchMoviesUseCase) {
        self.screenTitle = title
        self.useCase = useCase
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
