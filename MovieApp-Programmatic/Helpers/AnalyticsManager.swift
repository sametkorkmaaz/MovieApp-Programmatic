//
//  AnalyticsManager.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 22.11.2024.
//

import Foundation

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    private init() {}
    static let shared = AnalyticsManager()
    
    public func log(_ event: AnalyticsEvent) {
        guard let parameters = event.parameters else {
            return
        }
        Analytics.logEvent(event.eventName, parameters: parameters)
    }
}

protocol AnalyticsEventProtocol: Encodable {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
}

enum AnalyticsEvent: AnalyticsEventProtocol {
    case lookDetailMovie(LookDetailMovieEvent)
    
    var eventName: String {
        switch self {
        case .lookDetailMovie: return "look_detail_movie"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .lookDetailMovie(let event):
            return event.encodeToDictionary()
        }
    }
}

extension Encodable {
    func encodeToDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return dict
        } catch {
            print("Error encoding \(self): \(error)")
            return nil
        }
    }
}

struct LookDetailMovieEvent: Codable{
    let movieTitle: String
    let movieYear: String
    let movieImdb: String
    let origin: String
}

