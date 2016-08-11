//
//  GroceryItem+CoreDataProperties.swift
//  grocerylist
//
//  Created by Eric Giannini on 8/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GroceryItem {

    @NSManaged var name: String?
    @NSManaged var details: String?
    @NSManaged var purchased: NSNumber?
    @NSManaged var quantity: NSNumber?

}
