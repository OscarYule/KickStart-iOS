//
//  CourseTimetableModel.swift
//  ios_notepad
//
//  Created by LXie on 2/9/2023.
//

import UIKit

struct CourseTimetableModel: ModelBase {
    var time: String?
    
    var subject: String?
    
    var details: String?
    
    var roomStr: String?
    
    var courseStr: String?
    
    var noteId: Int?
    
    
    var courstModel: CourseTable?
    var courstTimeArray: [CourseTimeTable]?

}
