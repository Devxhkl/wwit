//
//  Two.swift
//  wwit
//
//  Created by Zel Marko on 02/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import Foundation
import CoreData

class Two: NSManagedObject {

    @NSManaged var done: NSNumber
    @NSManaged var priority: String
    @NSManaged var title: String
    @NSManaged var threes: NSSet
    @NSManaged var one: One
    
    class func createTwo(managedObjectContext: NSManagedObjectContext, _title: String, _priority: String, _done: Bool, _one: One) -> Two {
        let two = NSEntityDescription.insertNewObjectForEntityForName("Two", inManagedObjectContext: managedObjectContext) as! Two
        
        two.title = _title
        two.priority = _priority
        two.done = NSNumber(bool: _done)
        two.one = _one
        
        return two
    }
}
