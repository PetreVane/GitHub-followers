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
    case failedWritingDataToFile
    
    
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
            return "Failed parsing JSON returned by your network request."
        case .failedWritingDataToFile:
            return "Failed saving UserFavorites to user's documents directory"
        }
    }
}
