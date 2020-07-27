//
//  NavigationState.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-22.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

class NavigationState {
    
    var onBoarding: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: Constants.NavigationState.onBoardingKey.rawValue)
        }
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: Constants.NavigationState.onBoardingKey.rawValue)
            userDefaults.synchronize()
        }
    }
}
