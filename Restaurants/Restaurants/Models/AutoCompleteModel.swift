//
//  AutocompleteModel.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

struct AutoCompleteTermsModel: Codable {
    
    let terms: [AutoCompleteTextModel]
    
    enum CodingKeys: String, CodingKey {
        case terms
    }
}

struct AutoCompleteTextModel: Codable {
    
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text
    }
}
