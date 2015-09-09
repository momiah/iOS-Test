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
    
    // The link to the segmented control
    @IBOutlet
    var segmentedControl: UISegmentedControl!
    
    // JSON contents is stored here while being downloaded
    lazy var data = NSMutableData()
    
    // All tasks are stored here
    var tasks: NSMutableArray = []
    
    // The data to display
    var items: [String] = ["Loading..."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the cell class
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        startConnection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Classes for the UITableView */
    
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
    
    /* Classes for the UISegmentedControl */
    
    @IBAction
    func segmentedControlAction (sender: AnyObject) {
        updateTable()
    }
    
    /* Load file from URL asynchronously */
    
    func startConnection(){
        let urlPath: String = "https://raw.githubusercontent.com/fishrod-interactive/iOS-Test/master/data/tasklist.json"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var err: NSError
        
        // Parse file contents
        self.tasks = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSMutableArray
        
        updateTable()
    }
    
    // Method called to update the table displayed
    func updateTable() {
        items.removeAll(keepCapacity: false)
        
        // Go through data and append to table
        for task in tasks {
            //println(task)
            
            if segmentedControl.selectedSegmentIndex==0 && (task["done"] as! Bool) {
                continue
            }
            if segmentedControl.selectedSegmentIndex==1 && !(task["done"] as! Bool) {
                continue
            }
            
            items.append(task["task"] as! String)
        }
        
        // Update table
        self.tableView.reloadData()
    }


}

