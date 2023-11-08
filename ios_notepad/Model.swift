//
//  Model.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/28.
//

import UIKit

public protocol ModelBase {
    var time: String? { set  get}
    var subject: String? { set  get}
    var details: String? { set  get}
    var roomStr: String? { set  get}
    var courseStr: String? { set  get}

    var noteId: Int? { set  get}
  
}
