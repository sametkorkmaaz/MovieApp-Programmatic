//
//  BookmarkTableViewCell.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 19.11.2024.
//

import UIKit
import Kingfisher

class BookmarkTableViewCell: UITableViewCell {
    
    private lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .loodos
        return imageView
    }()
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .loodos
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    enum Identifier: String{
        case custom = "BookmarkCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        [moviePoster, movieTitle].forEach{
            contentView.addSubview($0)
        }
        [moviePoster, movieTitle].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            moviePoster.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.4),
            
            movieTitle.centerYAnchor.constraint(equalTo: moviePoster.centerYAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5),
            movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
        ])
    }
    
    func cellDataModel(model: Search){
        movieTitle.text = model.title
        if let poster = model.poster {
            moviePoster.kf.setImage(with: URL(string: poster))
        }
    }
    
}
