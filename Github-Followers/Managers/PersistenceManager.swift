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
        static let followers = "SavedFollowers"
    }
    
    private let storage = UserDefaults.standard
    private let userDocumentsDirectoryPath = FileManager.documentsDirectory
    static let sharedInstance = PersistenceManager()
    

    /// Gets data from User Defaults
    ///
    /// The return value contains a Result type, which holds an array of Followers, in case of success and ErrorManager message in case of failure
//    func retrieveFavorites() -> [Follower] {
//        var followers: [Follower] = []
//
//        // returns an empty array, in case there is no data saved in User Defaults
//        guard let retrievedData = storage.object(forKey: Keys.favorites) as? Data else { return followers }
//        let decoder = JSONDecoder()
//
//        do {
//            let decodedFollowers = try decoder.decode([Follower].self, from: retrievedData)
//            followers = decodedFollowers
//            return followers
//        }
//        catch {
//            print(ErrorManager.failedJSONParsing)
//        }
//
//        return followers
//    }
    
    
    /// Adds data to User Defaults
    /// - Parameter followers: array of Follower instances
    /// - return ErrorManager: optional ErrorManager message, in case saving has not completed successfully
//    func saveFavorite(_ followers: [Follower]) -> ErrorManager? {
//
//        var existingFavorites = retrieveFavorites()
//        existingFavorites.append(contentsOf: followers)
//        let encoder = JSONEncoder()
//
//        do {
//            let encodedData = try encoder.encode(existingFavorites)
//            storage.set(encodedData, forKey: Keys.favorites)
//            return nil
//        }
//        catch {
//            return .failedSavingData
//        }
//    }
    
    
    typealias error = ((ErrorManager?) -> Void)
    /// Updates the content of local plist file
    /// - Parameters:
    ///   - follower: Follower instance, which is either going to be removed or added to local plist file
    ///   - updateType: enum containing 2 types of action: adding & removing content
    ///   - completion: completion holding an optional ErrorManager message
    ///  -  reads the content of a plist file, located in User's Documents directory.
    ///  -  updates the content of the file, based on the selected updateType action
    ///  -  rewrites the file to user's Documents directory
    func updateFavoritesList(with follower: Follower, updateType: PersistenceUpdateType, completion: @escaping error) {
        print("updateFavoritesList called")
        var followers = retrieveSavedFollowers()
        
        switch updateType {
        case .add:
            guard !followers.contains(follower) else { completion(.alreadyInFavorites); return }
            followers.append(follower)
        case .remove:
            followers.removeAll { $0.login == follower.login }
        }
        completion(saveFollowers(followers))
    }
    
    
    /// Retrieves data from local file
    ///
    /// - reads the content of a plist file, located in User's Documents directory.
    /// - recodes data and returns an array of decoded Follower instances.
    /// - if decoding process fails, returns an empty array
    func retrieveSavedFollowers() -> [Follower] {
        print("retrieveSavedFollowers called")
        let noFollowers: [Follower] = []
        let plistDecoder = PropertyListDecoder()
        let file = userDocumentsDirectoryPath.appendingPathComponent(Keys.followers).appendingPathExtension("plist")
        guard let retrievedData = try? Data(contentsOf: file) else { return noFollowers }
        guard let decodedFollowers = try? plistDecoder.decode([Follower].self, from: retrievedData) else { return noFollowers }

        return decodedFollowers
    }
    
    /// Saves Follower object to a local plist file
    /// - Parameter follower: follower object to be saved
    ///
    /// - gets a reference to an existing file
    /// - reads the content of the file and appends new content (follower) to it
    /// - rewrites the file to user's Documents directory
    func saveFollowers(_ followers: [Follower]) -> ErrorManager? {
        print("SaveFavorites called")
        
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let fileToSaveInto = URL(fileURLWithPath: Keys.followers, relativeTo: userDocumentsDirectoryPath).appendingPathExtension("plist")
        
        do {
            
            let encodedData = try plistEncoder.encode(followers)
            try encodedData.write(to: fileToSaveInto, options: .atomic)
            return nil
            
        } catch {
            return .failedSavingData
        }
    }
    
}
