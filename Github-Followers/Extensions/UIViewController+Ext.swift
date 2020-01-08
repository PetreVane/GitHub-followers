//
//  UIViewController+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 08/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(with title: String, message: String, buttonTitle: String) {
        let alert = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        
        DispatchQueue.main.async {
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
