//
//  SplashViewModel.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation

protocol SplashViewModelInterface {
    
    func viewDidLoad()
    func fetchRemoteConfigValue()
    func chechNetworkConnection()
}
final class SplashViewModel {
    weak var view: SplashViewInterface?
    var splashText: String? {
        didSet {
            view?.splashTextAnimation(splashText: splashText)
        }
    }
}

extension SplashViewModel: SplashViewModelInterface {
    
    func viewDidLoad() {
        _ = NetworkMonitor.shared
        view?.preparePage()
        fetchRemoteConfigValue()
        chechNetworkConnection()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.chechNetworkConnection()
        }
    }
    
    func fetchRemoteConfigValue() {
        FirebaseRemoteConfig.shared.fetchRemoteConfigValue(remoteConfigKey: "splashText") { result in
            if let result = result {
                print(result)
                self.splashText = result
            }
        }
    }
    
    func chechNetworkConnection() {
        if NetworkMonitor.shared.isConnected {
            view?.presentSearchScreen()
        } else {
            view?.showNetworkError()
        }
    }
    

    
}
