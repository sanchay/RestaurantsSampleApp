//
//  Address+CoreDataClass.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case zip_code
        case state
        case country
        case city
        case address3
        case address2
        case address1
        case display_address
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Address", in: managedObjectContext) else {
            fatalError("Failed to decode Address")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        zip_code = try container.decodeIfPresent(String.self, forKey: .zip_code)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        address1 = try container.decodeIfPresent(String.self, forKey: .address1)
        address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        address3 = try container.decodeIfPresent(String.self, forKey: .address3)
        display_address = try container.decodeIfPresent([String].self, forKey: .display_address)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(zip_code, forKey: .zip_code)
        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(address1, forKey: .address1)
        try container.encodeIfPresent(address2, forKey: .address2)
        try container.encodeIfPresent(address3, forKey: .address3)
        try container.encodeIfPresent(display_address, forKey: .display_address)
    }
}

extension Address {
    
    var address: String {
        return display_address?.joined(separator: "\n") ?? ""
    }
}
