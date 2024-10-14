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

final class DetailViewModel {
    weak var view: DetailViewInterface?
}

extension DetailViewModel: DetailViewModelInterface{
    
    func viewDidLoad() {
        view?.preparePage()
    }
    
}
