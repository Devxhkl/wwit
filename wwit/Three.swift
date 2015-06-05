//
//  Three.swift
//  wwit
//
//  Created by Zel Marko on 02/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import Foundation
import CoreData

class Three: NSManagedObject {

    @NSManaged var done: NSNumber
    @NSManaged var priority: String
    @NSManaged var title: String
    @NSManaged var fours: NSSet
    @NSManaged var two: Two
    
    class func createThree(managedObjectContext: NSManagedObjectContext, _title: String, _priority: String, _done: Bool, _two: Two) -> Three {
        let three = NSEntityDescription.insertNewObjectForEntityForName("Three", inManagedObjectContext: managedObjectContext) as! Three
        
        three.title = _title
        three.priority = _priority
        three.done = NSNumber(bool: _done)
        three.two = _two
        
        return three
    }
}
