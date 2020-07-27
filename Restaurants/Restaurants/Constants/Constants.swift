//
//  Constants.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

enum Constants {
    
    enum Storyboard: String {
        case main = "Main"
    }
    
    enum Segue: String {
        case showAutoComplete
        case showSearchResults
        case showDetails
    }
    
    enum ViewController: String {
        case onBoarding = "onboarding"
        case search
        case tabViewController
    }
    
    enum Button {
        enum Layer: CGFloat {
            case cornerRadius = 5
        }
    }
    
    enum NavigationTitle: String {
        case search = "Search"
        case searchResults = "Restaurants"
        case favorites = "Favorites"
    }
    
    enum Text: String {
        case searchPlaceholder = "Search for restaurants"
        case locationPlaceholder = "Enter a location"
    }
    
    enum Image: String {
        case location = "location.fill"
    }
    
    enum Error: String {
        case applicationResourceNotFound = "Application resource not found"
        case locationDisabled = "Location not enabled"
        case currentLocation = "Cannot get current location"
        case coordinateData = "Cannot get coordinate data"
    }
    
    enum NavigationState: String {
        case onBoardingKey = "onboarding"
    }
    
    enum TableView {
        enum Cell: String {
            case identifier = "nameCellIdentifier"
            case favorite = "favorite"
        }
    }
    
    enum CollectionView {
        enum Cell: String {
            case identifier = "RestaurantCell"
        }
    }
    
    enum Sort: String {
        case asc = "Sort ↑"
        case desc = "Sort ↓"
    }
}
