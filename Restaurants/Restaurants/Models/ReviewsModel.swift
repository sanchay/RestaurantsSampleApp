//
//  ReviewModel.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

struct ReviewsModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case reviews
    }
    
    let reviews: [ReviewModel]
}

struct ReviewModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case time_created
        case user
    }
    
    let id: String
    let text: String
    let time_created: String
    let user: UserModel
}
