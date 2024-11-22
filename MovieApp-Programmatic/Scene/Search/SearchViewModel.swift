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
    func alert(with title: String, message: String)
}

final class SearchViewModel {
    weak var view: SearchViewInterface?
    
    var searchMovies: [Search] = []
}

extension SearchViewModel: SearchViewModelInterface{
    
    func viewDidLoad() {
        view?.preparePage()
        view?.setupActivityIndicator()
    }
    
    func fetchMovie(with query: String) {
        view?.startActivityIndicator()
        MovieService.shared.fetchMovies(movieTitle: query) { [weak self] result in
            guard let self = self else {
                print("sdadsada")
                return }
            
            switch result {
            case .success(let movieModel):
                if movieModel.search?.isEmpty ?? true {
                    self.searchMovies.removeAll()
                    DispatchQueue.main.async {
                        self.view?.reloadTableViewData()
                    }
                    self.alert(with: "Hata!", message: "Aradığınız kelimeye uygun film bulunamadı.")
                }
                if let movies = movieModel.search {
                    print(movies.count)
                    self.searchMovies = movies
                    DispatchQueue.main.async {
                        self.view?.reloadTableViewData()
                        self.view?.stopActivityIndicator()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func alert(with title: String, message: String) {
        view?.showAlert(with: title, message: message)
    }
    
}
