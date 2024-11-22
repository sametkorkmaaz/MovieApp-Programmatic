import Foundation
import UIKit
import CoreData

protocol DetailViewModelInterface {
    func viewDidLoad()
    func toggleBookmark()
    func addFirebaseAnalytics()
}

class DetailViewModel {
    weak var view: DetailViewInterface?
    var movieDetail: Search? // Seçilen filmin detaylarını tutacak
    var isBookmarked: Bool = false // Bookmark durumu

    func setMovieDetail(_ detail: Search) {
        self.movieDetail = detail
    }
}

extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.preparePage()
        checkIfBookmarked()
        addFirebaseAnalytics()
    }
    
    func addFirebaseAnalytics() {
        if let movie = movieDetail {
            AnalyticsManager.shared.log(.lookDetailMovie(.init(movieTitle: movie.title ?? "title error", movieYear: movie.year ?? "movie year error", movieImdb: movie.imdbID ?? "moving imdb error", origin: "DetailViewController")))
        }

    }
    
    func toggleBookmark() {
        isBookmarked.toggle()
        if isBookmarked {
            saveToCoreData()
        } else if let imdbID = movieDetail?.imdbID {
            deleteFromCoreData(imdbID: imdbID)
        }
        view?.updateBookmarkButton(isBookmarked: isBookmarked)
    }
    
    private func checkIfBookmarked() {
        guard let imdbID = movieDetail?.imdbID else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieImdb == %@", imdbID)
        
        do {
            let results = try context.fetch(fetchRequest)
            isBookmarked = !results.isEmpty
            view?.updateBookmarkButton(isBookmarked: isBookmarked)
        } catch {
            print("Error checking bookmark status: \(error.localizedDescription)")
        }
    }
    
    private func saveToCoreData() {
        guard let movieDetail = movieDetail else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let movieEntity = MovieEntity(context: context)
        
        movieEntity.title = movieDetail.title
        movieEntity.movieYear = movieDetail.year
        movieEntity.movieImdb = movieDetail.imdbID
        movieEntity.posterUrl = movieDetail.poster
        
        do {
            try context.save()
            print("Movie saved successfully.")
        } catch {
            print("Failed to save movie: \(error.localizedDescription)")
        }
    }
    
    private func deleteFromCoreData(imdbID: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieImdb == %@", imdbID)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let movieToDelete = results.first {
                context.delete(movieToDelete)
                try context.save()
                print("Movie deleted successfully.")
            }
        } catch {
            print("Failed to delete movie: \(error.localizedDescription)")
        }
    }
}
