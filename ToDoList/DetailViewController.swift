//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Jidde Koekoek on 01/05/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//

import UIKit
import SQLite

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    var index: Int?
    var todo: String?

    // MARK: SQLite database
    private var database: Connection?
    
    let toDo = Table("ToDo")
    let id = Expression<Int64>("id")
    let task = Expression<String?>("task")
    let detail = Expression<String?>("detail")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connect()
        retrieveDetail()
        
        // from: http://stackoverflow.com/questions/5085452/override-back-button-in-navigation-stack
        // & http://stackoverflow.com/questions/27713747/execute-action-when-back-bar-button-of-uinavigationcontroller-is-pressed
        
        // custom navigation button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: #selector(DetailViewController.backAction(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    /// retrieve the details from the database
    private func retrieveDetail() {
        if database != nil  && todo != nil{
            do {
                for thing in try database!.prepare(toDo.filter(task.like(todo!))) {
                    textField.text = thing[detail]
                }
            } catch {
                print("Could not retrieve details from database: \(error)")
            }
        }
    }
    
    // functionality added to the back button (autosave details)
    @objc private func backAction(sender:UIButton) {
        saveDetail()
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// save the details which goes with the todo
    private func saveDetail() {
        let placeInTable = toDo.filter(task == todo)
        do {
            try database!.run(placeInTable.update(detail <- textField.text!))
            print("Succes")
        } catch {
            print("Details not saved: \(error)") 
        }
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
}

















