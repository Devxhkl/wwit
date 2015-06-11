//
//  StageViewController.swift
//  wwit
//
//  Created by Zel Marko on 01/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class StageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var wwitTable: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var pathLabel: UILabel!
    
    let dataCenter = DataStoreCenter()
    var data = Array<AnyObject>()
    var stage: Int!
    var motherEntity: AnyObject!
    var lastPath = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        wwitTable.contentInset.top = 50.0
        wwitTable.estimatedRowHeight = 50.0
        wwitTable.rowHeight = UITableViewAutomaticDimension
        
        stage = navigationController!.viewControllers.count
        navigationController!.navigationBar.hidden = true
        
//        println("stage: \(stage)")
        
        if (motherEntity != nil) {
            pathLabel.text = lastPath + motherEntity.title!!
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData:", name: "freshData", object: nil)
    }
    
    func refreshData(notification: NSNotification) {
        let dict = notification.userInfo as! [Int: AnyObject]
        if let task: AnyObject = dict[stage] {
            data.append(task)
            wwitTable.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wwitCell", forIndexPath: indexPath) as! WwitCell
        
        cell.selectionStyle = .None
        cell.titleLabel.text = data[indexPath.row].title
        switch stage {
        case 2:
            let task = data[indexPath.row] as! Two
            if task.done as Bool {
                cell.backgroundColor = UIColor.greenColor()
            }
            else {
                cell.backgroundColor = UIColor.whiteColor()
            }
        case 3:
            let task = data[indexPath.row] as! Three
            if task.done as Bool {
                cell.backgroundColor = UIColor.greenColor()
            }
            else {
                cell.backgroundColor = UIColor.whiteColor()
            }
        case 4:
            let task = data[indexPath.row] as! Four
            if task.done as Bool {
                cell.backgroundColor = UIColor.greenColor()
            }
            else {
                cell.backgroundColor = UIColor.whiteColor()
            }
        case 5:
            let task = data[indexPath.row] as! Five
            if task.done as Bool {
                cell.backgroundColor = UIColor.greenColor()
            }
            else {
                cell.backgroundColor = UIColor.whiteColor()
            }
        default:
            println("invalid Stage")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if stage < 5 {
            let nextStage = storyboard?.instantiateViewControllerWithIdentifier("StageViewController") as! StageViewController
            navigationController?.pushViewController(nextStage, animated: true)
            nextStage.lastPath = pathLabel.text! + " > "
            
            switch stage {
            case 2:
                if let mother = data[indexPath.row] as? Two {
                    nextStage.motherEntity = mother
                    if let children = mother.threes.allObjects as? [Three] {
                        nextStage.data = children
                    }
                }
            case 3:
                if let mother = data[indexPath.row] as? Three {
                    nextStage.motherEntity = mother
                    if let children = mother.fours.allObjects as? [Four] {
                        nextStage.data = children
                    }
                }
            case 4:
                if let mother = data[indexPath.row] as? Four {
                    nextStage.motherEntity = mother
                    if let children = mother.fives.allObjects as? [Five] {
                        nextStage.data = children
                    }
                }
                
            default:
                println("Invalid case")
                
            }
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var doneAction = UITableViewRowAction(style: .Normal, title: "Done", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            self.dataCenter.markAsDone(self.stage, task: self.data[indexPath.row])
            self.wwitTable.reloadData()
        })
        
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            self.dataCenter.deleteTask(self.data[indexPath.row])
            self.data.removeAtIndex(indexPath.row)
            self.wwitTable.reloadData()
        })
        
        doneAction.backgroundColor = UIColor.greenColor()
        
        return [deleteAction, doneAction]
    }
    
    @IBAction func unwindFromAdd(segue: UIStoryboardSegue) {
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTaskSegue" {
            let addTaskVC = segue.destinationViewController as! AddTaskViewController
            addTaskVC.motherEntity = motherEntity
            addTaskVC.stage = stage
        }
    }


}
