//
//  One.swift
//  wwit
//
//  Created by Zel Marko on 02/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import Foundation
import CoreData

class One: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var priority: String
    @NSManaged var done: NSNumber
    @NSManaged var twos: NSSet
    
    class func createOne(managedObjectContext: NSManagedObjectContext, _title: String, _priority: String, _done: Bool) -> One {
        let one = NSEntityDescription.insertNewObjectForEntityForName("One", inManagedObjectContext: managedObjectContext) as! One
        
        one.title = _title
        one.priority = _priority
        one.done = NSNumber(bool: _done)
        
        return one
    }
}
