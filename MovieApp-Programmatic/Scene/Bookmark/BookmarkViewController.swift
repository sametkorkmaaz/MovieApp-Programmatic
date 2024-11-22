//
//  BookmarkViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 19.11.2024.
//

import UIKit

protocol BookmarkViewInterface: AnyObject {
    
    func preparePage()
    func tableViewReloadData()
}

final class BookmarkViewController: UIViewController {

    
    private let pageTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Bookmark"
        lbl.textColor = .loodos
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.Identifier.custom.rawValue)
        tableView.backgroundColor = .anaColor2
        return tableView
    }()
    
    private lazy var viewModel = BookmarkViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel.fetchBookmarkMovies()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension BookmarkViewController: BookmarkViewInterface {
    func preparePage() {
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .anaColor2
        
        [pageTitle, tableView].forEach{
            view.addSubview($0)
        }
        [pageTitle, tableView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    func tableViewReloadData() {
        tableView.reloadData()
    }
}

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarkMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.Identifier.custom.rawValue, for: indexPath) as? BookmarkTableViewCell else { return
            UITableViewCell() }
        cell.cellDataModel(model: viewModel.bookmarkMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let selectedMovie = viewModel.bookmarkMovies[indexPath.row]
        detailVC.viewModel.setMovieDetail(selectedMovie) // Seçilen filmi gönderiyoruz
        detailVC.modalPresentationStyle = .formSheet
        present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.2
    }
    
    
}
