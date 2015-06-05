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
    
    let dataCenter = DataStoreCenter()
    var data = [AnyObject]()
    var stage = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        stage = navigationController!.viewControllers.count
        navigationController!.navigationBar.hidden = true
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "recieveData:", name: "data", object: nil)
        
        dataCenter.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addThing(sender: AnyObject) {
        dataCenter.addTask(stage, title: "First task", priority: "ASAP")
    }
    
    func recieveData(notification: NSNotification) {
        
        if let ones = notification.userInfo!["One"] as? [AnyObject] {
            data = ones
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
        let nextStage = storyboard?.instantiateViewControllerWithIdentifier("StageViewController") as! StageViewController
        navigationController?.pushViewController(nextStage, animated: true)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
