//
//  MovieService.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

class MovieService {
    private let baseURL = "https://www.omdbapi.com/?s="
    private let serachTitle = "recep"
    private let apiKey = "&apikey=e4f84105"
    
    func fetchMovies(movieTitle: String, completion: @escaping (Result<MovieModel, NetworkError>) -> Void) {
        print("çalıştı")
        NetworkManager.shared.fetchData(from: "https://www.omdbapi.com/?s=recep&apikey=e4f84105") { (result: Result<MovieModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
