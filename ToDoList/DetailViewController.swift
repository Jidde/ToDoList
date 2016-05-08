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

    // MARK: SQLite database
    private var database: Connection?
    
    let toDo = Table("ToDo")
    let id = Expression<Int64>("id")
    let task = Expression<String?>("task")
    
    // details
    let detail = Expression<String?>("detail")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connect()
        
        // from: http://stackoverflow.com/questions/5085452/override-back-button-in-navigation-stack
        // & http://stackoverflow.com/questions/27713747/execute-action-when-back-bar-button-of-uinavigationcontroller-is-pressed
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: #selector(DetailViewController.backAction(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func backAction(sender:UIButton) {
        saveDetail()
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveDetail() {
        
        let insert = toDo.insert(detail <- textField.text!)
        
        do {
            let rowID = try database!.run(insert)
            print (rowID)
        } catch {
            print("Error creating to do: \(error)")
        }
    }
    
    private func connect() {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        do {
            database = try Connection("\(path)/db.sqlite3")
        } catch {
            print ("Cannot connect to database: \(error)")
        }
    }
}

















