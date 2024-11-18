//
//  SearchTableViewCell.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 25.10.2024.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

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
    private lazy var movieYear: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .loodos
        return label
    }()

    enum Identifier: String{
        case custom = "searchCell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        [moviePoster, movieTitle, movieYear].forEach{
            contentView.addSubview($0)
        }
        [moviePoster, movieTitle, movieYear].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            moviePoster.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.4),
            
            movieTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5),
            movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            movieYear.centerXAnchor.constraint(equalTo: movieTitle.centerXAnchor),
            movieYear.centerYAnchor.constraint(equalTo: moviePoster.centerYAnchor),
        ])
    }
    
    func cellDataModel(model: Search){
        movieTitle.text = model.title
        moviePoster.kf.setImage(with: URL(string: model.poster!))
        movieYear.text = model.year
    }

}
