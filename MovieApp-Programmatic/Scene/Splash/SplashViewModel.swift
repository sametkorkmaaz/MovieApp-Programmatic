//
//  SplashViewModel.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

protocol SplashViewModelInterface {
    func viewDidLoad()
}
final class SplashViewModel {
    weak var view: SplashViewInterface?
}

extension SplashViewModel: SplashViewModelInterface {
    func viewDidLoad() {
        view?.preparePage()
    }
}
