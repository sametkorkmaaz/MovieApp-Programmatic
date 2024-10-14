//
//  SearchViewModel.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

protocol SearchViewModelInterface {
    
    func viewDidLoad()
}

final class SearchViewModel {
    weak var view: SearchViewInterface?
}

extension SearchViewModel: SearchViewModelInterface{
    func viewDidLoad() {
        view?.preparePage()
    }
}
