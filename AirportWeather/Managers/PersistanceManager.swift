//
//  PersistanceManager.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    
    static func initializeDefaults() {
        guard defaults.object(forKey: "airports") == nil else {
            return
        }
        
        let defaultRecents: [RecentAirport] = [
            RecentAirport(airportSymbol: "KAUS"),
            RecentAirport(airportSymbol: "KPWM")
        ]
        
        if let error = save(recents: defaultRecents) {
            print("Error saving default recents: \(error)")
        }
    }
    
    
    static func updateRecentsWith(airportSymbol recent: RecentAirport, actionType: PersistanceActionType, completed: @escaping (AWError?) -> Void) {
        retrieveRecents { result in
            switch result {
            case .success(let recents):
                var retrievedRecents = recents
                
                switch actionType {
                case .add:
                    if retrievedRecents.contains(recent) {
                        retrievedRecents.removeAll { $0.airportSymbol == recent.airportSymbol }
                    }
                    retrievedRecents.append(recent)
                    
                    if retrievedRecents.count > 20 {
                        retrievedRecents.removeFirst()
                    }
                    
                case .remove:
                    retrievedRecents.removeAll { $0.airportSymbol == recent.airportSymbol }
                }
                
                completed(save(recents: retrievedRecents))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveRecents(completed: @escaping (Result<[RecentAirport], AWError>) -> Void) {
        guard let recentsData = defaults.object(forKey: "airports") as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let recents = try decoder.decode([RecentAirport].self, from: recentsData)
            completed(.success(recents))
            return
        } catch {
            completed(.failure(.unableToRetrieveRecents))
        }
    }
    
    
    static func save(recents: [RecentAirport]) -> AWError? {
        do {
            let encoder = JSONEncoder()
            let encodedRecents = try encoder.encode(recents)
            defaults.set(encodedRecents, forKey: "airports")
            return nil
        } catch {
            return .unableToAddToRecents
        }
    }
}
