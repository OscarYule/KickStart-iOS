//
//  AcivitesDataManage.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/28.
//

import UIKit
import GRDB

struct CourseTable: Codable, FetchableRecord, PersistableRecord, ModelBase {
    var roomStr: String?
    var time: String?
    var subject: String?
    var details: String?
    var noteId: Int?
    var courseStr: String? // 用来标记找到CourseTime
 }

class CourseDataManage: NSObject {

    static var dbQueue: DatabaseQueue!
    class func openDataBase(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        var phoneStr: String = UserDefaults.standard.string(forKey: String.phone) ?? "none" + "-course"
        
//        let file = path + "/\(phoneStr)" + "/DataBase.sqlite"
        
        let file = path  + "/\(phoneStr).sqlite"

        dbQueue = try! DatabaseQueue(path: file)
        try! self.dbQueue.inDatabase { (db) -> Void in
           
            if try db.tableExists("CourseTable") {
                debugPrint("HomeworkTable已经存在")
            }else{
                try db.create(table: "CourseTable") { t in
                    t.autoIncrementedPrimaryKey("noteId")
                    t.column("time", Database.ColumnType.text)
                    t.column("subject", Database.ColumnType.text)
                    t.column("details", Database.ColumnType.text)
                    t.column("roomStr", Database.ColumnType.text)
                    t.column("courseStr", Database.ColumnType.text)

                }
            }
        }
    }
   
    class func addNote(note:CourseTable){
        try! dbQueue.write { db in
            try note.insert(db)
        }
    }
    
    class func getNote()->[CourseTable]{
        var list:[CourseTable]!
        try! dbQueue.write { db in
             list =  try CourseTable.fetchAll(db,sql: "SELECT * FROM CourseTable")
        }
        return list;
    }
    
    class func selNote(courseStr: String) -> [CourseTable] {
        var list:[CourseTable]!
        try! dbQueue.write { db in
             list =  try CourseTable.fetchAll(db,sql: "SELECT * FROM CourseTable WHERE courseStr like '%\(courseStr)%'")
        }
        return list
    }
    
    class func selNote(time: String) -> [CourseTable] {
        var list:[CourseTable]!
        try! dbQueue.write { db in
             list =  try CourseTable.fetchAll(db,sql: "SELECT * FROM CourseTable WHERE time = ?", arguments: [time])
        }
        return list
    }
    
    class func updateNote(note:CourseTable){
        try! dbQueue.write { db in
            try note.update(db)
        }
    }
    class func deleteNote(note:HomeworkTable){
        try! dbQueue.write{ db in
            try note.delete(db)
        }
    }
    
    class func remoDB() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        var phoneStr: String = UserDefaults.standard.string(forKey: String.phone) ?? "none"
        let file = path  + "/\(phoneStr).sqlite"
        
        let exi = FileManager().fileExists(atPath: file)
        if exi {
            try! FileManager().removeItem(atPath: file)
        }
        
    }
}
