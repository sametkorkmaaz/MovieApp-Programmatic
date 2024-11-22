import UIKit
import Kingfisher
import FirebaseAnalytics

protocol DetailViewInterface: AnyObject {
    func preparePage()
    func updateBookmarkButton(isBookmarked: Bool)
}

class DetailViewController: UIViewController {

    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var movieYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var movieImdbLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = .loodos
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.addFirebaseAnalytics()
    }
    
    @objc func bookmarkButtonTapped() {
        viewModel.toggleBookmark()
    }
}

extension DetailViewController: DetailViewInterface {
    func preparePage() {
        view.backgroundColor = .anaColor2
        [movieImageView, movieTitleLabel, movieYearLabel, movieImdbLabel, bookmarkButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            movieImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            movieYearLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            movieYearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            movieImdbLabel.topAnchor.constraint(equalTo: movieYearLabel.bottomAnchor, constant: 10),
            movieImdbLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookmarkButton.topAnchor.constraint(equalTo: movieImdbLabel.bottomAnchor, constant: 20),
            bookmarkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 50),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // ViewModel'deki mevcut veriyi UI'ya aktar
        if let movie = viewModel.movieDetail {
            movieTitleLabel.text = movie.title
            movieYearLabel.text = "Year: \(movie.year ?? "N/A")"
            movieImdbLabel.text = "IMDB ID: \(movie.imdbID ?? "N/A")"
            if let posterURL = movie.poster, let url = URL(string: posterURL) {
                movieImageView.kf.setImage(with: url)
            } else {
                movieImageView.image = UIImage(systemName: "photo")
            }
        }
    }
    
    func updateBookmarkButton(isBookmarked: Bool) {
        let bookmarkImage = UIImage(
            systemName: isBookmarked ? "bookmark.fill" : "bookmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 500, weight: .bold)
        )
        bookmarkButton.setImage(bookmarkImage, for: .normal)
    }
}
