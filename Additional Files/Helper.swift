//
//  Helper.swift
//  Github-Followers
//
//  Created by Petre Vane on 16/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


struct Helper {
    
   static func configureCollectionViewFlowLayout(for view: UIView) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        // gets the width of the screen
        let width = view.bounds.width
        // adds some leading & trailing padding
        let padding: CGFloat = 12
        let distanceBetweenItems: CGFloat = 10
        // the total available width for cells
        let availableWidth = width - (padding * 2) - (distanceBetweenItems * 2)
        // size of 1 cell
        let itemWidth = availableWidth / 3
        // assigns padding to layout
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        //assigns item size as CGSize
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 35)
                
        return flowLayout
    }
    
}
