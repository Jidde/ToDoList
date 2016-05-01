//
//  ViewController.swift
//  ToDoList
//
//  Created by Jidde Koekoek on 25/04/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let placeholderArray = ["test","test2","test3","test4","test5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return placeholderArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        cell?.textLabel!.text = placeholderArray[indexPath.row]
        
        return cell!
    }


    // did select row
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue" {
            if let svc = segue.destinationViewController as? DetailViewController {

            }
        }
    }
    
    
    
}

