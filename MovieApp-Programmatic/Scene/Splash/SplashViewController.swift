//
//  SplashViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import UIKit

protocol SplashViewInterface: AnyObject {
    
    func preparePage()
}

final class SplashViewController: UIViewController {
    // http://www.omdbapi.com/?s=recep&apikey=e4f84105
    private lazy var viewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    /*    MovieService().fetchMovies(movieTitle: "recep") { result in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        } */
    }
}

extension SplashViewController: SplashViewInterface {
    func preparePage() {
        view.backgroundColor = .red
    }
}
