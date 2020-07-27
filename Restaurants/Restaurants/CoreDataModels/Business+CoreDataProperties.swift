//
//  Business+CoreDataProperties.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//
//

import Foundation
import CoreData


extension Business {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Business> {
        return NSFetchRequest<Business>(entityName: "Business")
    }

    @NSManaged public var alias: String?
    @NSManaged public var display_phone: String?
    @NSManaged public var id: String?
    @NSManaged public var image_url: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var rating: Float
    @NSManaged public var review_count: Int32
    @NSManaged public var url: String?
    @NSManaged public var categories: NSSet?
    @NSManaged public var location: Address?

}

// MARK: Generated accessors for categories
extension Business {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}
