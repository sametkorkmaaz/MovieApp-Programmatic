//
//  SearchViewModel.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

protocol SearchViewModelInterface {
    
    func viewDidLoad()
    func fetchMovie(with query: String)
}

final class SearchViewModel {
    weak var view: SearchViewInterface?
    
    var searchMovies: [Search] = []
}

extension SearchViewModel: SearchViewModelInterface{
    
    func viewDidLoad() {
        view?.preparePage()
    }
    
    func fetchMovie(with query: String) {
        print("viewmodel fetch")
        MovieService.shared.fetchMovies(movieTitle: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movieModel):
                if let movies = movieModel.search {
                    self.searchMovies = movies
                    DispatchQueue.main.async {
                        self.view?.reloadTableViewData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
