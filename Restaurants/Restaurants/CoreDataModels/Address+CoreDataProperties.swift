//
//  Address+CoreDataProperties.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var zip_code: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var city: String?
    @NSManaged public var address3: String?
    @NSManaged public var address2: String?
    @NSManaged public var address1: String?
    @NSManaged public var display_address: [String]?
    @NSManaged public var business: Business?

}
