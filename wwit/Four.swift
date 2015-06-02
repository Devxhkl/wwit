//
//  Four.swift
//  wwit
//
//  Created by Zel Marko on 02/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import Foundation
import CoreData

class Four: NSManagedObject {

    @NSManaged var done: NSNumber
    @NSManaged var priority: String
    @NSManaged var title: String
    @NSManaged var fives: NSSet
    @NSManaged var three: Three
    
    class func createOne(managedObjectContext: NSManagedObjectContext, _title: String, _priority: String, _done: Bool, _three: Three) -> Four {
        let four = NSEntityDescription.insertNewObjectForEntityForName("Four", inManagedObjectContext: managedObjectContext) as! Four
        
        four.title = _title
        four.priority = _priority
        four.done = NSNumber(bool: _done)
        four.three = _three
        
        return four
    }
}
