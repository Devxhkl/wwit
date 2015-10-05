//
//  AddTaskViewController.swift
//  wwit
//
//  Created by Zel Marko on 07/06/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    var motherEntity: AnyObject!
    var stage = 1

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var addTaskButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitleTextField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }

    @IBAction func addTask(sender: AnyObject) {
        let dataStoreCenter = DataStoreCenter()
        if stage == 1 {
            dataStoreCenter.addMainTask(taskTitleTextField.text!, priority: "ASAP")
        }
        else {
            dataStoreCenter.addStageTask(stage, title: taskTitleTextField.text!, priority: "Test", motherEntity: motherEntity)
        }
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        taskTextFieldBottomConstraint.constant = 40.0
        addTaskButtonBottomConstraint.constant = 8.0
        cancelButtonBottomConstraint.constant = 120.0
        
        UIView.animateWithDuration(0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            taskTextFieldBottomConstraint.constant = 40.0
            addTaskButtonBottomConstraint.constant = 8.0
            cancelButtonBottomConstraint.constant = 120.0
            
            UIView.animateWithDuration(0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        return true
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                taskTextFieldBottomConstraint.constant = 8.0
                addTaskButtonBottomConstraint.constant = 8.0
                cancelButtonBottomConstraint.constant = 8.0 + keyboardHeight
                
                UIView.animateWithDuration(0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
}
