//
//  BusinessesModel.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

struct RestaurantsModel: Codable {
    
    let businesses: [RestaurantModel]
    
    enum CodingKeys: String, CodingKey {
        case businesses
    }
}
