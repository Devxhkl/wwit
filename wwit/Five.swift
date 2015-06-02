//
//  Five.swift
//  wwit
//
//  Created by Zel Marko on 02/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import Foundation
import CoreData

class Five: NSManagedObject {

    @NSManaged var done: NSNumber
    @NSManaged var priority: String
    @NSManaged var title: String
    @NSManaged var four: Four
    
    class func createOne(managedObjectContext: NSManagedObjectContext, _title: String, _priority: String, _done: Bool, _four: Four) -> Five {
        let five = NSEntityDescription.insertNewObjectForEntityForName("Five", inManagedObjectContext: managedObjectContext) as! Five
        
        five.title = _title
        five.priority = _priority
        five.done = NSNumber(bool: _done)
        five.four = _four
        
        return five
    }
}
