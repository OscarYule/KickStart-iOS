//
//  String+Extension.swift
//  ios_notepad
//
//  Created by LXie on 29/8/2023.
//

import Foundation

// MARK: - 时间转换
extension String {
    func timeWitMoonTime() -> String {
        if (self.count < 1) {
            return self
        }
        
        let array = self.components(separatedBy: "-")
        
        if (array.count < 2) {
            return self
        }
        
        var moonStr = array[1]
        
        if (moonStr == "01") {
            moonStr = "Jan"
        }else if (moonStr == "02") {
            moonStr = "Feb"
        }else if (moonStr == "03") {
            moonStr = "Mar"
        }else if (moonStr == "04") {
            moonStr = "Apr"
        }else if (moonStr == "05") {
            moonStr = "May"
        }else if (moonStr == "06") {
            moonStr = "Jun"
        }else if (moonStr == "07") {
            moonStr = "Jul"
        }else if (moonStr == "08") {
            moonStr = "Aug"
        }else if (moonStr == "09") {
            moonStr = "Sept"
        }else if (moonStr == "10") {
            moonStr = "Oct"
        }else if (moonStr == "11") {
            moonStr = "Nov"
        }else if (moonStr == "12") {
            moonStr = "Dec"
        }

        return (moonStr+" "+array[2]+","+array[0])
    }
    
    func timeWitHHmmTime() -> String {
        if (self.count < 1) {
            return self
        }
        
        let array = self.components(separatedBy: ":")
        
        if (array.count < 1) {
            return self
        }
        
        var hh = Int(array[0])!
        var mm = array[1]
        var aa = "AM"
        if  hh > 12 {
            hh -= 12
            aa = "PM"
        }
        
        return ("\(hh):\(mm) \(aa)")
     }

}
