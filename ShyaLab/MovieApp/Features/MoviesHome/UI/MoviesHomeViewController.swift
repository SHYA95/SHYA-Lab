//
//  MoviesHomeViewController.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import UIKit
import Combine

class MoviesHomeViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - Properties
    private let viewModel: MoviesHomeViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    
    init(viewModel: MoviesHomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadMovies()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func bindViewModel() {
        // Binding logic will go here
    }
}
