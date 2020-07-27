//
//  CustomNavigationController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension CustomNavigationController {
    
    func configure() {
        
        let storyboard = UIStoryboard(name: Constants.Storyboard.main.rawValue, bundle: nil)
        guard let onBoardingViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.onBoarding.rawValue) as? OnboardingViewController else {
            fatalError(Constants.Error.applicationResourceNotFound.rawValue)
        }
        
        guard let searchViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.tabViewController.rawValue) as? UITabBarController else {
            fatalError(Constants.Error.applicationResourceNotFound.rawValue)
        }
        
        if NavigationState().onBoarding {
            self.setViewControllers([searchViewController], animated: true)
        } else {
            self.setViewControllers([onBoardingViewController], animated: true)
        }
    }
}
