//
//  CoreDataHelper.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper {
    
    public class func reset() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.persistentContainer.viewContext.reset()
    }
    
    public class func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    public class func restaurant(id: String) -> Business? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.includesPendingChanges = false
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            return result.first
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public class func deleteRestaurant(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Business.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.includesPendingChanges = false
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistentStoreCoordinator.execute(deleteRequest, with: managedObjectContext)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public class func addRestaurant(object: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.insert(object)
    }
    
    public class func isRestaurantSaved(id: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.includesPendingChanges = false
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            return result.count > 0
        } catch let error {
            print(error)
        }
        return false
    }
    
    public class func fetchSavedRestaurants() -> [Business]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
        fetchRequest.includesPendingChanges = false
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public class func clearRestaurants() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Business.fetchRequest()
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistentStoreCoordinator.execute(deleteRequest, with: managedObjectContext)
        } catch let error as NSError {
            print(error)
        }
    }
}
