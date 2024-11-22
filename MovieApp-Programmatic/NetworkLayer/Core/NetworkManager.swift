//
//  NetworkManager.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance
    
    private init() {}
    
    // Generic 
    func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

