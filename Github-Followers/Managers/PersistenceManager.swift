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
        static let followers = "SavedFollowers"
    }
    
    private let userDocumentsDirectoryPath = FileManager.documentsDirectory
    static let sharedInstance = PersistenceManager()
    
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
