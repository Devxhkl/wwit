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
    
    var data = [AnyObject]()
    var stage = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stage = navigationController!.viewControllers.count
        navigationController!.navigationBar.hidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addThing(sender: AnyObject) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wwitCell", forIndexPath: indexPath) as! WwitCell
        
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
