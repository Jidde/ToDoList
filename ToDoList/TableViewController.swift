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
    
    var tasks = [String]()

    let toDo = Table("ToDo")
    let id = Expression<Int64>("id")
    let task = Expression<String?>("task")
    let detail = Expression<String?>("detail")
    
    private var database: Connection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connect()
        retrieveToDos()

//        do {
//           try database!.run(toDo.drop())
//            print("Table succesfully deleted")
//        } catch {
//            print("de eenmalige drop table is al gedaan")
//        }
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// connect to the database
    private func connect() {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        do {
            database = try Connection("\(path)/db.sqlite3")
        } catch {
            print ("Cannot connect to database: \(error)")
        }
    }
    
    /// retrieve todo's
    private func retrieveToDos() {
        if database != nil {
            do {
                for todo in try database!.prepare(toDo) {
                    tasks.append(todo[task]!)
                }
            } catch {
                print("Could not retrieve data from database: \(error)")
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        cell?.textLabel!.text = tasks[indexPath.row]
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    
    // Override to support editing the table view; from: https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson9.html
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let del = toDo.filter(task == tasks[indexPath.row])
            do {
                if try database!.run(del.delete()) > 0 {
                    print("Todo deleted")
                }
                else{
                    print("Todo not deleted")
                }
            } catch {
                print("Delete failed: \(error)")
            }
            tasks.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            if let dvc = segue.destinationViewController as? DetailViewController {
                let indexPath = self.tableView.indexPathForSelectedRow
                dvc.index = indexPath!.row
                dvc.todo = tasks[indexPath!.row]
            }
        }
    }
}







