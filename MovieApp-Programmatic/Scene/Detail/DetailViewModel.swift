//
//  DetailViewModel.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

protocol DetailViewModelInterface{
    
    func viewDidLoad()
}

class DetailViewModel {
    weak var view: DetailViewInterface?
    
    var movieDetail: Search? // Seçilen filmin detaylarını tutacak
    
    func setMovieDetail(_ detail: Search) {
        self.movieDetail = detail
    }
}

extension DetailViewModel: DetailViewModelInterface{
    
    func viewDidLoad() {
        view?.preparePage()
    }
    
}
