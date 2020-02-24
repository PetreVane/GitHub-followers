//
//  PersistenceManager.swift
//  Github-Followers
//
//  Created by Petre Vane on 05/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation


enum PersistenceUpdateType {
    case add
    case remove
}

struct PersistenceManager {
    
    /// Simple key, to avoid typos
    enum Keys {
        static let favorites = "favorites"
    }
    
    private let storage = UserDefaults.standard
    static let sharedInstance = PersistenceManager()
    

    /// Gets data from User Defaults
    ///
    /// The return value contains a Result type, which holds an array of Followers, in case of success and ErrorManager message in case of failure
    func retrieveFavorites() -> [Follower] {
        var followers: [Follower] = []
    
        // returns an empty array, in case there is no data saved in User Defaults
        guard let retrievedData = storage.object(forKey: Keys.favorites) as? Data else { return followers }
        let decoder = JSONDecoder()
        
        do {
            let decodedFollowers = try decoder.decode([Follower].self, from: retrievedData)
            followers = decodedFollowers
            return followers
        }
        catch {
            print(ErrorManager.failedJSONParsing)
        }
        
        return followers
    }
    
    
    /// Adds data to User Defaults
    /// - Parameter followers: array of Follower instances
    /// - return ErrorManager: optional ErrorManager message, in case saving has not completed successfully
    func saveFavorite(_ followers: [Follower]) -> ErrorManager? {
        
        var existingFavorites = retrieveFavorites()
        existingFavorites.append(contentsOf: followers)
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(existingFavorites)
            storage.set(encodedData, forKey: Keys.favorites)
            return nil
        }
        catch {
            return .failedSavingData
        }
    }
    
    
    typealias error = ((ErrorManager?) -> Void)
    /// Updates existing User Defaults data
    /// - Parameters:
    ///   - follower: Follower instance, which is either going to be removed or added to User Defaults
    ///   - updateType: enum containing 2 types of action: adding & removing from User Defaults
    ///   - completion: completion holding an optional ErrorManager message
    ///
    /// This method accepts a Follower instance, and based on the selected updateType option, will either add a new Follower to User Defaults or remove an existing Follower from User Defaults. Therefore, this method calls retrieveFavorites(_) method, and based on the result, proceeds with adding / removing the passed in Follower.
    func updateFavoritesList(with follower: Follower, updateType: PersistenceUpdateType, completion: @escaping error) {
        
        var followers = retrieveFavorites()
        
        switch updateType {
        case .add:
            guard !followers.contains(follower) else { completion(.alreadyInFavorites); return }
            followers.append(follower)
            
        case .remove:
            followers.removeAll { $0.login == follower.login }
        }
        completion(saveFavorite(followers))
    }
}
