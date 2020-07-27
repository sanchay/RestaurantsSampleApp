//
//  Category+CoreDataProperties.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var alias: String?
    @NSManaged public var title: String?
    @NSManaged public var business: Business?

}
