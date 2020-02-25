//
//  FileManager+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 25/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

extension FileManager {
    
    static var documentsDirectory: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
