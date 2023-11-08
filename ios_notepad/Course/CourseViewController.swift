//
//  CourseViewController.swift
//  ios_notepad
//
//  Created by LXie on 16/8/2023.
//

import UIKit

class CourseViewController: UIViewController {
    
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var instructorField: UITextField!
    @IBOutlet weak var classroomField: UITextField!
    
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var selBgView: UIView!
    
    var addTimeArray : [CourseTimeTable] = []
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewLayoutH: NSLayoutConstraint!

    typealias saveAction = () -> Void
    
    var saveBlock: saveAction?
    
    var model: CourseTable?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        CourseDataTimeManager.openDataBase()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "CourseTimeCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        var height = addTimeArray.count > 5 ? 5.0 * 40 : CGFloat(addTimeArray.count * 40)
        tableViewLayoutH.constant = height
        
        var str = Date().getString(format: "HH:mm")
        timeLabel.text = str.timeWitHHmmTime()
        
        
        let stt = Date().weekDay()
        dayLabel.text = stt
        
        selBgView.isHidden = true
        
        if (model != nil) {
            titLabel.text = "Edit Exams"
            courseField.text = model?.subject
            instructorField.text = model?.details
            classroomField.text = model?.roomStr
          
            var arry = CourseDataTimeManager.selNoteAll(superTime: (model?.time)!)
            if (arry.count > 0) {
                addTimeArray = arry
                tableView.reloadData()
                tableViewLayoutH.constant = CGFloat(addTimeArray.count * 40)
            }
            
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func weekAction(_ sender: Any) {
        
        selBgView.isHidden = false
    }
    
    @IBAction func timeAction(_ sender: Any) {
        let datePicker = YLDatePicker(currentDate: nil, minLimitDate: nil, maxLimitDate: nil, datePickerType: .Hm) { [weak self] (date) in
            var str = date.getString(format: "HH:mm")
            self?.timeLabel.text = str.timeWitHHmmTime()
        }
        datePicker.show()
    }
    
    
    @IBAction func addTimeAction(_ sender: Any) {
        if (dayLabel.text?.count ?? 0 < 1 || timeLabel.text?.count ?? 0 < 1) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Content is wrong", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        var model = CourseTimeTable()
        model.addTime = String(Date().timeIntervalSince1970)
        model.dayWeek = self.dayLabel.text
        model.dayTime = self.timeLabel.text
        model.superTime = ""
        CourseDataTimeManager.addNote(note: model)
        addTimeArray.append(model)
        
        var str = Date().getString(format: "HH:mm")
        timeLabel.text = str.timeWitHHmmTime()
        tableView.reloadData()
        
        tableViewLayoutH.constant = CGFloat(addTimeArray.count * 40)
        
    }
    
    
 
    @IBAction func sureAction(_ sender: Any) {
        if (courseField.text?.count ?? 0 < 1 || instructorField.text?.count ?? 0 < 1 || classroomField.text?.count ?? 0 < 1 || addTimeArray.count < 1) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Content is wrong", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        if (model != nil) {
            var noteTable = model!
            noteTable.subject = courseField.text
            noteTable.details = instructorField.text
            noteTable.roomStr = classroomField.text
 
            var weekStr = ""
            for var model:CourseTimeTable in addTimeArray {
    //            model.superTime = noteTable.time
                
                if (!weekStr.contains("\(model.dayWeek!),")) {
                    weekStr.append(contentsOf: ("\(model.dayWeek!),"))
                }
                
                var model1 =  CourseDataTimeManager.selNote(addTime: model.addTime ?? "")
                model1?.superTime = noteTable.time

                if (model1 != nil) {
                    CourseDataTimeManager.updateNote(note: model1!)
                }
            }
            
            noteTable.courseStr = weekStr
            
            CourseDataManage.updateNote(note:noteTable)
            
        }else {
        
        var noteTable = CourseTable()
        noteTable.subject = courseField.text
        noteTable.details = instructorField.text
        noteTable.roomStr = classroomField.text
        noteTable.time = String(Date().timeIntervalSince1970)

        
        var weekStr = ""
        for var model:CourseTimeTable in addTimeArray {
//            model.superTime = noteTable.time
            
            if (!weekStr.contains("\(model.dayWeek!),")) {
                weekStr.append(contentsOf: ("\(model.dayWeek!),"))
            }
            
            var model1 =  CourseDataTimeManager.selNote(addTime: model.addTime ?? "")
            model1?.superTime = noteTable.time

            if (model1 != nil) {
                CourseDataTimeManager.updateNote(note: model1!)
            }
        }
        
        noteTable.courseStr = weekStr
        
        CourseDataManage.addNote(note:noteTable)
        }
        
        if (saveBlock != nil) {
            saveBlock!()
        }
        
        dismiss(animated: true)
        
    }
    
    
    
    @IBAction func cancelSelBgView(_ sender: Any) {
        selBgView.isHidden = true
    }
    
    
    
    @IBAction func weekDayAction(_ sender: UIButton) {
        dayLabel.text = sender.titleLabel?.text
        
        selBgView.isHidden = true
    }
    
}

 extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addTimeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: CourseTimeTable = addTimeArray[indexPath.row]
        var cell: CourseTimeCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseTimeCell
        cell.selectionStyle = .none
        cell.timeLabel.text = model.dayWeek! + " at " + model.dayTime!
        return cell
    }
    
}
