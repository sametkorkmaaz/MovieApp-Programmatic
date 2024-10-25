//
//  FirebaseRemoteConfig.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 14.10.2024.
//

import Foundation
import FirebaseRemoteConfig

protocol FirebaseRemoteConfigInterface {
    
    func fetchRemoteConfigValue(remoteConfigKey: String, completion: @escaping (String?) -> Void)
    func setupRemoteConfigDefaults()
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void)
}

class FirebaseRemoteConfig: FirebaseRemoteConfigInterface {
    static let shared = FirebaseRemoteConfig()
    
    public func fetchRemoteConfigValue(remoteConfigKey: String, completion: @escaping (String?) -> Void) {
        setupRemoteConfigDefaults()
        
        fetchRemoteConfig { result in
            let value = RemoteConfig.remoteConfig().configValue(forKey: remoteConfigKey).stringValue
            completion(value) // Değeri geri döndür
        }
    }

    public func setupRemoteConfigDefaults() {
        let defaultValues = [
            "splashText": "Default text!" as NSObject,
            "labelConstrainConstant": 50 as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }

    public func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        let debugSettings = RemoteConfigSettings()
        debugSettings.minimumFetchInterval = 0 // Debug modunda hemen fetch yap
        RemoteConfig.remoteConfig().configSettings = debugSettings

        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { status, error in
            if error == nil {
                RemoteConfig.remoteConfig().activate { _, _ in
                    print("Retrieved values from the cloud!")
                    completion(true)
                }
            } else {
                print("Error fetching remote config: \(String(describing: error))")
                completion(false)
            }
        }
    }
}
