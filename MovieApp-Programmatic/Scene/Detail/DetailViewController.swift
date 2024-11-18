//
//  DetailViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import UIKit
import Kingfisher

protocol DetailViewInterface: AnyObject {
    
    func preparePage()
}

class DetailViewController: UIViewController {
// DETAY SAYFASINA YORUM SATIRI EKLEDİMMMM
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .loodos
        return imageView
    }()
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.font = .systemFont(ofSize: .init(25))
        return label
    }()
    private lazy var movieYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.font = .systemFont(ofSize: .init(20))
        return label
    }()
    private lazy var movieImdbLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.font = .systemFont(ofSize: .init(20))
        return label
    }()
    
    lazy var viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension DetailViewController: DetailViewInterface {
    
    func preparePage() {
        view.backgroundColor = .anaColor2
        
        [movieImageView, movieImdbLabel, movieYearLabel, movieTitleLabel].forEach{
            view.addSubview($0)
        }
        [movieImageView, movieImdbLabel, movieYearLabel, movieTitleLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            movieImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: view.frame.height * 0.05),
            movieTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            movieYearLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: view.frame.height * 0.05),
            movieYearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            movieImdbLabel.topAnchor.constraint(equalTo: movieYearLabel.bottomAnchor, constant: view.frame.height * 0.05),
            movieImdbLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // ViewModel'deki verileri alıp görselleştiriyoruz
        if let movie = viewModel.movieDetail {
            movieTitleLabel.text = movie.title
            movieYearLabel.text = "Year: \(movie.year ?? "N/A")"
            movieImdbLabel.text = "IMDB ID: \(movie.imdbID ?? "N/A")"
            
            if let posterURL = movie.poster, let url = URL(string: posterURL) {
                movieImageView.kf.setImage(with: url)
            } else {
                movieImageView.image = UIImage(named: "placeholder") // Varsayılan görsel
            }
        }
    }
}
