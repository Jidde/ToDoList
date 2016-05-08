//
//  Database.swift
//  ToDoList
//
//  Created by Jidde Koekoek on 02/05/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//
//  SQLite: https://github.com/stephencelis/SQLite.swift
//
//  Class with the functionality for the database
//  WORK IN PROGRESS (REFACTORING)

import Foundation
import SQLite

class database {
//    
//    private let toDo = Table("ToDo")
//    private let id = Expression<Int64>("id")
//    private let task = Expression<String?>("task")
//    private let detail = Expression<String?>("detail")
//    
//    try db.run(toDo.create { t in
//    t.column(id, primaryKey: true)
//    t.column(task)
//    t.column(detail)
//    })
    
    
    /// connect to the database
//    func connect() {
//        private let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
//        
//        do {
//            database = try Connection("\(path)/db.sqlite3")
//        } catch {
//            print ("Cannot connect to database: \(error)")
//        }
//    }
    
    
//    func createTable () {
//        
//        do {
//            try database!.run(toDo.create(ifNotExists: true) { t in
//                t.column(id, primaryKey: .Autoincrement)
//                t.column(task, unique: true)
//                t.column(detail)
//                } )
//        } catch {
//            print ("Cannot create table: \(error)")
//        }
//    }
//
    
    /// retrieve data from the database
//    func retrieveDetail() {
//        if database != nil  && todo != nil{
//            do {
//                for thing in try database!.prepare(toDo.filter(task.like(todo!))) {
//                    textField.text = thing[detail]
//                }
//            } catch {
//                print("Could not retrieve details from database: \(error)")
//            }
//        }
//    }
    
    /// insert data in the database
    
    
    /// update information from the database
//    func saveDetail() {
//        
//        let placeInTable = toDo.filter(task == todo)
//        
//        do {
//            try database!.run(placeInTable.update(detail <- textField.text!))
//        } catch {
//            print("Details not saved: \(error)")
//        }
//    }
    
    
//    func deleteTodo () {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            
//            let del = toDo.filter(task == task)
//            
//            do {
//                if try database!.run(del.delete()) > 0 {
//                    print("Todo deleted")
//                }
//                else{
//                    print("Todo not deleted")
//                }
//            } catch {
//                print("Delete failed: \(error)")
//            }
//            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//    }
    
    
    
}






