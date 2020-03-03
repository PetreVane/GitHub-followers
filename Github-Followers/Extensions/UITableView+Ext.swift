//
//  UITableView+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/03/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Removes empty cells from TableView
    func removeEmptyCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
