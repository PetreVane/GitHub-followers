//
//  NetworkManager.swift
//  Github-Followers
//
//  Created by Petre Vane on 09/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation


class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    private init () {
        
    }
    
    typealias completionHandler = ((Error, URLResponse, Data) -> Void)
    typealias result = (([Follower]?, ErrorManager?) -> Void)
    
    
    /// Creates a network request to GitHub 'Users' endpoint
    /// - Parameters:
    ///   - user: GitHub user name for which the followers are requested
    ///   - page: Followers page number
    ///   - completion: Result of the request
    func getFollowers(for user: String, page: Int, completion: @escaping result) {
        
        // declares the endpoint URL
        let endPointURL: String = "https://api.github.com/users/\(user)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPointURL) else { completion(nil, ErrorManager.failedURL); return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { completion(nil, ErrorManager.failedNetworkRequest); return }
            guard let serverResponse = response as? HTTPURLResponse,
                serverResponse.statusCode == 200 else {completion(nil, ErrorManager.unexpectedStatusCode); return }
            
            guard let receivedData = data else { completion(nil, ErrorManager.invalidData); return }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode([Follower].self, from: receivedData)
                completion(decodedData, nil)
                
            } catch let error {
                print("Error: \(error.localizedDescription)")
                completion(nil, ErrorManager.failedJSONParsing)
            }
            
        }
        task.resume()
    }
    
}
