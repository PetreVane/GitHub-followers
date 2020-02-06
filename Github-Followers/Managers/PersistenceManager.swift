//
//  PersistenceManager.swift
//  Github-Followers
//
//  Created by Petre Vane on 05/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation


enum PersistenceActionType {
    case add
    case remove
}

enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    enum Keys {
        static let favorites = "favorites"
    }

    typealias result = ((Result<[Follower], ErrorManager>) -> Void)
    /// Fetches data from User Defaults
    /// - Parameter completion: Result type
    ///
    /// The completion handler contains a Result type, which holds an array of Followers, in case of success and ErrorManager message in case of failure
    static func retrieveFavorites(completion: @escaping result) {
        
        // returns an empty array, in case there is no data saved in User Defaults
        guard let retrievedData = defaults.object(forKey: Keys.favorites) as? Data else { completion(.success([])); return }
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([Follower].self, from: retrievedData)
            completion(.success(decodedData))
            
        } catch {
            completion(.failure(.failedJSONParsing))
        }
    }
    
    
    /// Adds data to User Defaults
    /// - Parameter followers: array of Follower instances
    static func saveFavorite(_ followers: [Follower]) -> ErrorManager? {
        
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(followers)
            defaults.set(encodedData, forKey: Keys.favorites)
            return nil
    
            } catch {
            return .failedSavingData
        }
    }
    
    
    typealias error = ((ErrorManager?) -> Void)
    /// Updates existing User Defaults data
    /// - Parameters:
    ///   - follower: Follower instance, which is either going to be removed or added to User Defaults
    ///   - updateType: enum containing 2 types of action: adding & removing from User Defaults
    ///   - completion: completion holding an  optional ErrorManager message
    ///
    /// This method accepts a Follower instance, and based on the selected updateType option, will either add a new Follower to User Defaults or remove an existing Follower from User Defaults. Therefore, this method calls retrieveFavorites(_) method, and based on the result, proceeds with adding / removing the passed in Follower.
    static func updateFavoritesList(with follower: Follower, updateType: PersistenceActionType, completion: @escaping error) {
        
        retrieveFavorites { result in
            
            switch result {
            case .success(let favorites):
                var followers = favorites
           
                switch updateType {
                case .add:
                    guard !followers.contains(follower) else { completion(.alreadyInFavorites); return }
                    followers.append(follower)
                    
                case .remove:
                    followers.removeAll { $0.login == follower.login }
                }
                
                completion(saveFavorite(followers))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
}
