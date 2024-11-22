//
//  WebViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 19.11.2024.
//

import UIKit
import WebKit

protocol WebViewInterface: AnyObject {
    
    func setupActivityIndicator()
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class WebViewController: UIViewController {

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 200 ,y: 300, width: 130, height: 130)) as UIActivityIndicatorView
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    private let pageTitle: UILabel = {
            let label = UILabel()
            label.textColor = .loodos
            label.font = .systemFont(ofSize: .init(18), weight: .bold)
            label.textAlignment = .left
            label.text = "loodos Website"
            return label
        }()
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .loodos
        let url = URL(string: "https://loodos.com")!
        webView.load(URLRequest(url: url))
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePage()
        setupActivityIndicator()
        startActivityIndicator()
    }
    
    func preparePage() {
        view.backgroundColor = .anaColor2
        backButton.addTarget(self, action: #selector(goBackPage), for: .touchUpInside)
                [backButton, pageTitle, webView, activityIndicator].forEach{
                    view.addSubview($0)
                }
                [backButton, pageTitle, webView, activityIndicator].forEach{
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            
            pageTitle.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            pageTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            pageTitle.heightAnchor.constraint(equalTo: backButton.heightAnchor),
            
            webView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func goBackPage() {
        dismiss(animated: true, completion: nil) // Modal sayfayı kapatır ve önceki sayfaya döner
    }
}

extension WebViewController: WebViewInterface {
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .loodos
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.backgroundColor = (UIColor (white: 0.8, alpha: 0.8))
        activityIndicator.layer.cornerRadius = 10
        self.view.addSubview(activityIndicator)
        }
    
    func startActivityIndicator() {
        print("start")
        activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopActivityIndicator()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
