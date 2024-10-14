//
//  SearchViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import UIKit

protocol SearchViewInterface: AnyObject {
    func preparePage()
}

final class SearchViewController: UIViewController {

    private lazy var viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

extension SearchViewController: SearchViewInterface {
    func preparePage() {
        view.backgroundColor = .orange
    }
}
