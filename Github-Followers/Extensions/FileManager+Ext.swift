//
//  FileManager+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 25/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

extension FileManager {
    
    /// Returns an URL to .documentDirectory in .userDomainMask for this app
    static var documentsDirectory: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
