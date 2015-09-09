//
//  ViewController.swift
//  Autolayout
//
//  Created by Muhammed Miah on 09/09/2015.
//  Copyright (c) 2015 Muhammed Miah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame = CGRectOffset(self.view.superview!.frame, 0, -100);
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame = CGRectOffset(self.view.superview!.frame, 0, 0);
    }


}

