//
//  MainTabBarController.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import UIKit

public class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabs()
    }
    
    // MARK: - Private Setup Methods
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    private func setupTabs() {
        let repository = MoviesRepository()
        
        let nowPlayingUseCase = GetNowPlayingMoviesUseCase(repository: repository)
        let nowPlayingVM = MoviesHomeViewModel(title: "Now Playing", useCase: nowPlayingUseCase)
        let nowPlayingVC = MoviesHomeViewController(viewModel: nowPlayingVM)
        
        let nowPlayingNav = createNavController(
            for: nowPlayingVC,
            title: "Now Playing",
            imageName: "play.circle.fill"
        )
        
        let popularUseCase = GetPopularMoviesUseCase(repository: repository)
        let popularVM = MoviesHomeViewModel(title: "Popular", useCase: popularUseCase)
        let popularVC = MoviesHomeViewController(viewModel: popularVM)
        
        let popularNav = createNavController(
            for: popularVC,
            title: "Popular",
            imageName: "flame.fill"
        )
        
        let upcomingUseCase = GetUpcomingMoviesUseCase(repository: repository)
        let upcomingVM = MoviesHomeViewModel(title: "Upcoming", useCase: upcomingUseCase)
        let upcomingVC = MoviesHomeViewController(viewModel: upcomingVM)
        
        let upcomingNav = createNavController(
            for: upcomingVC,
            title: "Upcoming",
            imageName: "calendar"
        )
        
        viewControllers = [nowPlayingNav, popularNav, upcomingNav]
    }
    
    // MARK: - Helper Methods
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     imageName: String) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        
        return navController
    }
}
