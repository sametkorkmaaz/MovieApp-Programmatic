//
//  BookmarkViewModel.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 19.11.2024.
//

import Foundation
import UIKit
import CoreData

protocol BookmarkViewModelInterface{
    
    func viewDidLoad()
    func fetchBookmarkMovies()
}

final class BookmarkViewModel {
    weak var view: BookmarkViewInterface?
    var bookmarkMovies: [Search] = []
}

extension BookmarkViewModel: BookmarkViewModelInterface {
    func viewDidLoad() {
        view?.preparePage()
        fetchBookmarkMovies()
        print("didloaad")
    }
    
    // CoreData'dan bookmark verilerini çekme
    func fetchBookmarkMovies() {
        // AppDelegate'deki persistentContainer'a erişim
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found.")
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let movieEntities = try context.fetch(fetchRequest)
            bookmarkMovies = movieEntities.compactMap { entity in
                Search(
                    title: entity.title,
                    year: entity.movieYear,
                    imdbID: entity.movieImdb,
                    poster: entity.posterUrl
                )
            }
            print("Fetched \(bookmarkMovies.count) bookmark movies.")
            view?.tableViewReloadData()
        } catch {
            print("Failed to fetch bookmark movies: \(error.localizedDescription)")
        }
    }
}

