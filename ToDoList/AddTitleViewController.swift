//
//  AddTitleViewController.swift
//  ToDoList
//
//  Created by Jidde Koekoek on 02/05/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//

import UIKit
import SQLite

class AddTitleViewController: UIViewController {
    
    @IBOutlet weak var inputToDo: UITextField!
    @IBOutlet weak var cancelToDo: UIButton!
    @IBOutlet weak var saveToDo: UIButton!

    // MARK: SQLite database
    private var database: Connection?
    
    let toDo = Table("ToDo")
    let id = Expression<Int64>("id")
    let task = Expression<String?>("task")
    
    // details
    let detail = Expression<String?>("detail")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDatabase()
        createTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveToDo(sender: AnyObject) {
        let insert = toDo.insert(task <- inputToDo.text!)
        do {
            let rowID = try database!.run(insert)
            print (rowID)
        } catch {
            print("Error creating to do: \(error)")
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func setUpDatabase() {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        do {
            database = try Connection("\(path)/db.sqlite3")
        } catch {
            print ("Cannot connect to database: \(error)")
        }
    }
    
    private func createTable () {
        do {
            try database!.run(toDo.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .Autoincrement)
                t.column(task, unique: true)
                t.column(detail)
                } )
        } catch {
            print ("Cannot create table: \(error)")
        }
    }
    
    @IBAction func cancelTodo(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}













