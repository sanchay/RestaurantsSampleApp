//
//  UserModel.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    let name: String
}
