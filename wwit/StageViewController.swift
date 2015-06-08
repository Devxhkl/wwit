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
    
    var data = Array<AnyObject>()
    var stage: Int!
    var motherEntity: AnyObject!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        stage = navigationController!.viewControllers.count
        navigationController!.navigationBar.hidden = true
        
        println("stage: \(stage)")
        
        if (motherEntity != nil) {
            println(motherEntity!.title!)
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
        
        cell.titleLabel.text = data[indexPath.row].title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if stage < 5 {
            let nextStage = storyboard?.instantiateViewControllerWithIdentifier("StageViewController") as! StageViewController
            navigationController?.pushViewController(nextStage, animated: true)
            
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
