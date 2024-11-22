//
//  SplashViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import UIKit

protocol SplashViewInterface: AnyObject {
    
    func preparePage()
    func splashTextAnimation(splashText: String?)
    func presentSearchScreen()
    func showNetworkError()
}

final class SplashViewController: UIViewController {
    // http://www.omdbapi.com/?s=recep&apikey=e4f84105
    
    private lazy var splashTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loodos
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var viewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SplashViewController: SplashViewInterface {
    
    func preparePage() {
        view.backgroundColor = .anaColor2
        [splashTextLabel].forEach{
            view.addSubview($0)
        }
        [splashTextLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            splashTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func splashTextAnimation(splashText: String?) {
        if let splashText = splashText {
            DispatchQueue.main.async {
                self.splashTextLabel.text = splashText
            }
        }
    }
    
    func presentSearchScreen() {
        let Tabbar_VC = TabbarViewController()
        Tabbar_VC.modalPresentationStyle = .fullScreen
        present(Tabbar_VC, animated: false, completion: nil)
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "İnternet yok!", message: "Lütfen internet bağlantınızı kontrol ediniz.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
            self.viewModel.chechNetworkConnection()
        }))
        self.present(alert, animated: true, completion: nil)
            
        }
    }

    
    
