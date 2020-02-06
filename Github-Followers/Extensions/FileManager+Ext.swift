//
//  FileManager+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 05/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
