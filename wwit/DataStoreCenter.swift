//
//  DataStoreCenter.swift
//  wwit
//
//  Created by Zel Marko on 02/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit
import CoreData

class DataStoreCenter: NSObject {
   
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    var ones = [One]()
    
}

extension DataStoreCenter {
    
    func getData() {
        
        let request = NSFetchRequest(entityName: "One")
        let data = managedObjectContext.executeFetchRequest(request, error: nil)
        
        if let one = data {
            
            ones = one as! [One]
            println(ones.count)
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName("data", object: nil, userInfo: ["One": ones])

            
        }
    }
        
    func addTask(stage: Int, title: String, priority: String) {
        switch stage {
        case 1:
            One.createOne(managedObjectContext, _title: title, _priority: priority, _done: false)
            
            var error: NSError?
            if managedObjectContext.save(&error) {
                println("saved *** One ***")
                getData()
            }
//            Two.createTwo(managedObjectContext, _title: title, _priority: priority, _done: false, _one: nil)
        default:
            println()
        }
    }
}
