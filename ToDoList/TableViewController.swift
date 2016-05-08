//
//  ViewController.swift
//  ToDoList
//
//  Created by Jidde Koekoek on 25/04/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//

import UIKit
import SQLite

class TableViewController: UITableViewController {
    
    let placeholderArray = ["test","test2","test3","test4","test5"]
    var tasks = [String]()

    let toDo = Table("ToDo")
    let id = Expression<Int64>("id")
    let task = Expression<String?>("task")
    
    // details
    let detail = Expression<String?>("detail")
    
    private var database: Connection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connect()
        retrieveToDos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func connect() {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        do {
            database = try Connection("\(path)/db.sqlite3")
        } catch {
            print ("Cannot connect to database: \(error)")
        }
    }
    
    private func retrieveToDos() {
        if database != nil {
            do {
                for todo in try database!.prepare(toDo) {
                    print("id: \(todo[id]), task: \(todo[task]!)")
                    tasks.append(todo[task]!)
                    print(tasks)
                }
            } catch {
                print("Could not retrieve data from database: \(error)")
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return placeholderArray.count
        return tasks.count

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        //cell?.textLabel!.text = placeholderArray[indexPath.row]
        cell?.textLabel!.text = tasks[indexPath.row]
        
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    
    
    
}







