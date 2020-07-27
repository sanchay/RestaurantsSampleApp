//
//  RestaurantModel.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

struct RestaurantModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case alias
        case display_phone
        case id
        case image_url
        case name
        case phone
        case price
        case rating
        case review_count
        case url
        case location
    }
    
    let alias: String?
    let display_phone: String?
    let id: String?
    let image_url: String?
    let name: String?
    let phone: String?
    let price: String?
    let rating: Float
    let review_count: Int32
    let url: String?
    let location: AddressModel
}
