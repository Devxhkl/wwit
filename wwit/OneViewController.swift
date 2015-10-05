//
//  OneViewController.swift
//  wwit
//
//  Created by Zel Marko on 08/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    
    @IBOutlet weak var wwitTable: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    let dataCenter = DataStoreCenter()
    var data: Array<AnyObject>!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        wwitTable.contentInset.top = 50.0
        wwitTable.estimatedRowHeight = 50.0
        wwitTable.rowHeight = UITableViewAutomaticDimension
        
        navigationController!.navigationBar.hidden = true

        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "recieveData:", name: "data", object: nil)
        
        if data == nil {
            dataCenter.getData()
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let task = data[indexPath.row] as! One
        
        if task.done as Bool {
            cell.backgroundColor = UIColor.greenColor()
        }
        else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let doneAction = UITableViewRowAction(style: .Normal, title: "Done", handler: { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            
            self.dataCenter.markAsDone(1, task: self.data[indexPath.row])
            self.wwitTable.reloadData()
        })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            
            self.dataCenter.deleteTask(self.data[indexPath.row])
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
    
    func recieveData(notification: NSNotification) {
        
        if let ones = notification.userInfo!["One"] as? [AnyObject] {
            data = ones
            wwitTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "oneToStageSegue" {
            let stageViewController = segue.destinationViewController as! StageViewController
            let indexPath = wwitTable.indexPathForCell(sender as! WwitCell)
            
            if let mother = data[indexPath!.row] as? One {
                stageViewController.motherEntity = mother
                
                if let children = mother.twos.allObjects as? [Two] {
                    stageViewController.data = children
                }
            }
        }
    }


}
