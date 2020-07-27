//
//  FavViewPresenter.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

class FavViewPresenter {
    
    class func fetchFavorites() -> [Business]? {
        return CoreDataHelper.fetchSavedRestaurants()
    }
}
