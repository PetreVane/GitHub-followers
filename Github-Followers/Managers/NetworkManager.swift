//
//  NetworkManager.swift
//  Github-Followers
//
//  Created by Petre Vane on 09/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


class NetworkManager {
    
    static let sharedInstance = NetworkManager()
        
    typealias result = ((Result<[Follower], ErrorManager>) -> Void)
    
    
    /// Creates a network request to GitHub 'Users' endpoint
    /// - Parameters:
    ///   - user: GitHub user name for which the followers are requested
    ///   - page: Followers page number
    ///   - completion: Result of the request
    func fetchFollowers(for user: String, page: Int, completion: @escaping result) {
        
        // declares the endpoint URL
        let endPointURL: String = "https://api.github.com/users/\(user)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPointURL) else { completion(.failure(.failedURL)); return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { completion(.failure(.failedNetworkRequest)); return }
            guard let serverResponse = response as? HTTPURLResponse,
                serverResponse.statusCode == 200 else {completion(.failure(.unexpectedStatusCode)); return }
            
            guard let receivedData = data else { completion(.failure(.invalidData)); return }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode([Follower].self, from: receivedData)
                completion(.success(decodedData))
                
            } catch {
                completion(.failure(.failedJSONParsing))
            }
        }
        task.resume()
    }
    
    
    /// Fetches avatar images of GitHub followers
    /// - Parameters:
    ///   - StringUrl: URL of the avatar, casted as String
    ///   - completion: escaping completion containing the avatar
    func fetchAvatars(from StringUrl: String, completion: @escaping (UIImage) -> Void) {
        
        guard let imageURL = URL(string: StringUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            guard error == nil else { return }
            guard let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode == 200 else { return }
            guard let receivedData = data else { return }
            
            if let image = UIImage(data: receivedData) {
                completion(image)
            }
        }; task.resume()
    }
 }
