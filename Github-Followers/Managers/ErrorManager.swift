//
//  ErrorManager.swift
//  Github-Followers
//
//  Created by Petre Vane on 09/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation


/// Enumerates possible errors taking place while making a network call and handlig JSON received from network
enum ErrorManager: Error {
    
    case failedURL
    case failedNetworkRequest
    case unexpectedStatusCode
    case invalidData
    case failedJSONParsing
    case missingData
    case failedSavingData
    case alreadyInFavorites
    
    
    var localizedDescription: String {
        
        switch self {

        case .failedURL:
            return "Soometing went wrong when trying to cast String type to URL type."
        case .failedNetworkRequest:
            return "Something went wrong. Make sure you're connected to Internet and try again later."
        case .unexpectedStatusCode:
            return "Unable to find the requested user 🥺"
        case .invalidData:
            return "Invalid data returned by the server."
        case .failedJSONParsing:
            return "There were some problems transforming your data."
        case .failedSavingData:
            return "Failed saving Follower to your favorites list 🥺"
        case .missingData:
            return "Failed fetching data from User Defaults"
        case .alreadyInFavorites:
            return "This user is already in your favorites list 🥳"
        }
    }
}
