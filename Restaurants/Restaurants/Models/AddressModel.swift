//
//  AddressModel.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-24.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

struct AddressModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case display_address
    }
    
    let display_address: [String]
}

extension AddressModel {
    
    var address: String {
        return display_address.joined(separator: "\n")
    }
}
