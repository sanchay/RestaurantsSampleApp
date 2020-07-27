//
//  Business+CoreDataClass.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Business)
public class Business: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case alias
        case display_phone
        case id
        case image_url
        case name
        case phone
        case rating
        case review_count
        case url
        case categories
        case location
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Business", in: managedObjectContext) else {
            fatalError("Failed to decode Business")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        alias = try container.decodeIfPresent(String.self, forKey: .alias)
        display_phone = try container.decodeIfPresent(String.self, forKey: .display_phone)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        image_url = try container.decodeIfPresent(String.self, forKey: .image_url)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        rating = try container.decode(Float.self, forKey: .rating)
        review_count = try container.decode(Int32.self, forKey: .review_count)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        location = try container.decodeIfPresent(Address.self, forKey: .location)
        
        let tempCategories: [Category] = try container.decode([Category].self, forKey: .categories)
        categories = NSSet(array: tempCategories)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(alias, forKey: .alias)
        try container.encodeIfPresent(display_phone, forKey: .display_phone)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(image_url, forKey: .image_url)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(review_count, forKey: .review_count)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(categories?.allObjects as? [Category], forKey: .categories)
    }
}
