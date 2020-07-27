//
//  TabBarController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        title = Constants.NavigationTitle.search.rawValue
        navigationItem.hidesBackButton = true
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is SearchTermViewController {
            title = Constants.NavigationTitle.search.rawValue
        }
        
        if viewController is FavViewController {
            title = Constants.NavigationTitle.favorites.rawValue
        }
    }
}
