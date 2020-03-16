//
//  DeviceTypes.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/03/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Gets screen size details
public enum ScreenSize {
    public static let width        = UIScreen.main.bounds.size.width
    public static let height       = UIScreen.main.bounds.size.height
    public static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    public static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


/// Gets device type details
public enum DeviceTypes {
    public static let idiom                    = UIDevice.current.userInterfaceIdiom
    public static let nativeScale              = UIScreen.main.nativeScale
    public static let scale                    = UIScreen.main.scale
 
    public static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    public static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    public static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    public static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    public static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    public static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    public static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    public static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    public static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}

