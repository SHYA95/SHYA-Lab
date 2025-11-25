//
//  MoviesHomeViewController.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import UIKit
import Combine

class MoviesHomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - Properties
    private let viewModel: MoviesHomeViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Int, Movie>!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    // MARK: - Init
    init(viewModel: MoviesHomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "MoviesHomeViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        configureDataSource()
        bindViewModel()
        viewModel.loadMovies()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = viewModel.title
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureTableView() {
        tableview.delegate = self
        tableview.registerNib(cell: MoviesTableViewCell.self)
        tableview.rowHeight = 260
        tableview.separatorStyle = .none
    }
    
    // MARK: - Data Source (Diffable)
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Movie>(tableView: tableview) { (tableView, indexPath, movie) -> UITableViewCell? in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: movie)
            return cell
        }
    }
    
    // MARK: - Binding (Reacting to ViewModel Outputs)
    private func bindViewModel() {
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.tableview.isHidden = true
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        // 2. Handle Data (Success)
        viewModel.moviesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.tableview.isHidden = false
                self?.applySnapshot(movies: movies)
            }
            .store(in: &cancellables)
        
        // 3. Handle Error
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Methods
    private func applySnapshot(movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.viewModel.loadMovies()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - TableView Delegate
extension MoviesHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        
        print("Selected: \(movie.title)")
    }
}
