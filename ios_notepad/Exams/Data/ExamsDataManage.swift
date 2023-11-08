//
//  AcivitesDataManage.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/28.
//

import UIKit
import GRDB

struct ExamsTable: Codable, FetchableRecord, PersistableRecord, ModelBase {
    var time: String?
    var subject: String?
    var details: String?
    var roomStr: String?
    var courseStr: String? // 用来标记找到CourseTime

    var noteId: Int?
}

class ExamsDataManage: NSObject {

    static var dbQueue: DatabaseQueue!
    class func openDataBase(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        var phoneStr: String = UserDefaults.standard.string(forKey: String.phone) ?? "none" + "-exams"
        
//        let file = path + "/\(phoneStr)" + "/DataBase.sqlite"
        
        let file = path  + "/\(phoneStr).sqlite"

        dbQueue = try! DatabaseQueue(path: file)
        try! self.dbQueue.inDatabase { (db) -> Void in
           
            if try db.tableExists("ExamsTable") {
                debugPrint("ExamsTable已经存在")
            }else{
                try db.create(table: "ExamsTable") { t in
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
   
    class func addNote(note:ExamsTable){
        try! dbQueue.write { db in
            try note.insert(db)
        }
    }
    
    class func getNote()->[ExamsTable]{
        var list:[ExamsTable]!
        try! dbQueue.write { db in
             list =  try ExamsTable.fetchAll(db,sql: "SELECT * FROM ExamsTable")
        }
        return list;
    }
    class func updateNote(note:ExamsTable){
        try! dbQueue.write { db in
            try note.update(db)
        }
    }
    class func deleteNote(note:ExamsTable){
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
