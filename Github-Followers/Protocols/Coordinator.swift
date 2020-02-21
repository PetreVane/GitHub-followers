//
//  Coordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 11/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var router: NavigationRouter { get set }
}
