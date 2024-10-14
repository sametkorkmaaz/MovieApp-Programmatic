//
//  DetailViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    
    func preparePage()
}

final class DetailViewController: UIViewController {
// DETAY SAYFASINA YORUM SATIRI EKLEDİMMMM 
    private lazy var viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension DetailViewController: DetailViewInterface {
    func preparePage() {
        view.backgroundColor = .blue
    }
    
    
}
