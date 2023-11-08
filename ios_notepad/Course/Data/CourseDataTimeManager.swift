//
//  CourseDataTimeManager.swift
//  ios_notepad
//
//  Created by LXie on 30/8/2023.
//

import Foundation
import GRDB
 
struct CourseTimeTable: Codable, FetchableRecord, PersistableRecord {
    var addTime: String?
    var superTime: String? // 关联
    var dayWeek: String?
    var dayTime: String?
    var noteId: Int?
}

class CourseDataTimeManager: NSObject {

    static var dbQueue: DatabaseQueue!
    class func openDataBase(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        var phoneStr: String = UserDefaults.standard.string(forKey: String.phone) ?? "none" + "-courseTime"
        
//        let file = path + "/\(phoneStr)" + "/DataBase.sqlite"
        
        let file = path  + "/\(phoneStr).sqlite"

        dbQueue = try! DatabaseQueue(path: file)
        try! self.dbQueue.inDatabase { (db) -> Void in
           
            if try db.tableExists("CourseTimeTable") {
                debugPrint("CourseTimeTable已经存在")
            }else{
                try db.create(table: "CourseTimeTable") { t in
                    t.autoIncrementedPrimaryKey("noteId")
                    t.column("addTime", Database.ColumnType.text)
                    t.column("superTime", Database.ColumnType.text)
                    t.column("dayWeek", Database.ColumnType.text)
                    t.column("dayTime", Database.ColumnType.text)
                }
            }
        }
    }
   
    class func addNote(note:CourseTimeTable){
        try! dbQueue.write { db in
            try note.insert(db)
        }
    }
    
    class func getNote()->[CourseTimeTable]{
        var list:[CourseTimeTable]!
        try! dbQueue.write { db in
             list =  try CourseTimeTable.fetchAll(db,sql: "SELECT * FROM CourseTimeTable")
        }
        return list;
    }
    
 
    class func selNote(addTime: String) -> CourseTimeTable? {
        var list:[CourseTimeTable]!
        try! dbQueue.write { db in
             list =  try CourseTimeTable.fetchAll(db,sql: "SELECT * FROM CourseTimeTable WHERE addTime = ?", arguments: [addTime])
        }
        return list.first
    }
    
    class func selNote(dayWeek: String) -> [CourseTimeTable] {
        var list:[CourseTimeTable]!
        try! dbQueue.write { db in
             list =  try CourseTimeTable.fetchAll(db,sql: "SELECT * FROM CourseTimeTable WHERE dayWeek = ?", arguments: [dayWeek])
        }
        return list
    }
    
    class func selNoteAll(superTime: String) -> [CourseTimeTable] {
        var list:[CourseTimeTable]!
        try! dbQueue.write { db in
             list =  try CourseTimeTable.fetchAll(db,sql: "SELECT * FROM CourseTimeTable WHERE superTime = ?", arguments: [superTime])
        }
        return list
    }
    
    class func updateNote(note:CourseTimeTable){
        try! dbQueue.write { db in
            try note.update(db)
        }
    }
    class func deleteNote(note:CourseTimeTable){
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
