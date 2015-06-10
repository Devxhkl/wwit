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
    let notificationCenter = NSNotificationCenter.defaultCenter()
}

extension DataStoreCenter {
    
    func getData() {
        
        let request = NSFetchRequest(entityName: "One")
        let data = managedObjectContext.executeFetchRequest(request, error: nil)
        
        if let one = data {
            
            ones = one as! [One]
//            println(ones.count)
            
            notificationCenter.postNotificationName("data", object: nil, userInfo: ["One": ones])

            
        }
    }
        
    func addMainTask(title: String, priority: String) {
        
        One.createOne(managedObjectContext, _title: title, _priority: priority, _done: false)
        
        var error: NSError?
        if managedObjectContext.save(&error) {
            println("saved main task")
            getData()
        }
    }
    
    func addStageTask(stage: Int, title: String, priority: String, motherEntity: AnyObject) {
        var freshData: AnyObject!
        
        switch stage {
        case 2:
            freshData = Two.createTwo(managedObjectContext, _title: title, _priority: priority, _done: false, _one: motherEntity as! One) as Two
        case 3:
            freshData = Three.createThree(managedObjectContext, _title: title, _priority: priority, _done: false, _two: motherEntity as! Two) as Three
        case 4:
            freshData = Four.createFour(managedObjectContext, _title: title, _priority: priority, _done: false, _three: motherEntity as! Three) as Four
        case 5:
            freshData = Five.createFive(managedObjectContext, _title: title, _priority: priority, _done: false, _four: motherEntity as! Four) as Five
        default:
            println("Invalid stage")
        }
        
        var error: NSError?
        if managedObjectContext.save(&error) {
            notificationCenter.postNotificationName("freshData", object: nil, userInfo: [stage: freshData])
            println("saved stage \(stage) task")
            getData()
        }
    }
    
    func markAsDone(stage: Int, task: AnyObject) {
        switch stage {
        case 1:
            (task as! One).done = 1
        case 2:
            (task as! Two).done = 1
        case 3:
            (task as! Three).done = 1
        case 4:
            (task as! Four).done = 1
        case 5:
            (task as! Five).done = 1
        default:
            println("Invalid stage")
        }
        
        var error: NSError?
        if managedObjectContext.save(&error) {
            println("saved \(task.title) as Done")
            getData()
        }
    }
    
    func deleteTask(task: AnyObject) {
        managedObjectContext.deleteObject(task as! NSManagedObject)
        
        var error: NSError?
        if managedObjectContext.save(&error) {
            println("Deleted")
            getData()
        }
    }
    
}
