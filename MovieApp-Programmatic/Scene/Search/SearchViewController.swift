//
//  SearchViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import UIKit

protocol SearchViewInterface: AnyObject {
    
    func preparePage()
    func reloadTableViewData()
    func showAlert(with title: String, message: String)
    func setupActivityIndicator()
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class SearchViewController: UIViewController {

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 100 ,y: 150, width: 80, height: 80)) as UIActivityIndicatorView
    private lazy var searchTitle: UILabel = {
        let searchTitle = UILabel()
        searchTitle.text = "Kefiyli Seyirler"
        searchTitle.font = .systemFont(ofSize: 24, weight: .bold)
        searchTitle.textColor = .loodos
        return searchTitle
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .anaColor2
        searchBar.showsCancelButton = true
        searchBar.showsCancelButton.toggle()
        searchBar.delegate = self
        return searchBar
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.Identifier.custom.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true) // Geri dönerken tekrar göster
    }
}

extension SearchViewController: SearchViewInterface {
    
    func preparePage() {
        view.backgroundColor = .anaColor2
        [searchTitle, searchBar, tableView].forEach{
            view.addSubview($0)
        }
        
        [searchTitle, searchBar, tableView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            searchBar.topAnchor.constraint(equalTo: searchTitle.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func reloadTableViewData() {
        print("reload tablevİEW")
        tableView.reloadData()
    }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            self.stopActivityIndicator()
        }
    }
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .loodos
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.backgroundColor = .anaColor2
        activityIndicator.layer.cornerRadius = 10
        self.view.addSubview(activityIndicator)
        }
    
    func startActivityIndicator() {
        print("start")
        activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.Identifier.custom.rawValue, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
       
        cell.cellDataModel(model: Search(title: viewModel.searchMovies[indexPath.row].title, year: viewModel.searchMovies[indexPath.row].year, imdbID: viewModel.searchMovies[indexPath.row].imdbID, poster: viewModel.searchMovies[indexPath.row].poster))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let selectedMovie = viewModel.searchMovies[indexPath.row]
        detailVC.viewModel.setMovieDetail(selectedMovie) // Seçilen filmi gönderiyoruz
        detailVC.modalPresentationStyle = .formSheet
        present(detailVC, animated: true, completion: nil)
    }
}
extension SearchViewController: UISearchBarDelegate {
    
    // Arama çubuğuna metin girdikçe tetiklenen metod
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            print("Arama Metni: \(searchText)")
            viewModel.fetchMovie(with: searchText)
        }
    }
    
    // Arama butonuna basıldığında tetiklenen metod
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Arama butonuna tıklandı")
        searchBar.resignFirstResponder()  // Klavyeyi gizler
    }

    // Arama çubuğu iptal edildiğinde tetiklenen met
}
