//
//  ViewController.swift
//  Networking
//
//  Created by Muhammed Miah on 09/09/2015.
//  Copyright (c) 2015 Muhammed Miah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // The link to the table on the page
    @IBOutlet
    var tableView: UITableView!
    
    // The data to display
    var items: [String] = ["Task 1", "Task 2", "Task 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the cell class
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Classes made to conform to protocols for UITableView */
    
    
    // Set the number of rows in the table on the page to the number
    // of items in the data object
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    // Set the value of each row in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    


}

