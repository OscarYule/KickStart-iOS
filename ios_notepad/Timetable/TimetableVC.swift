//
//  TimetableVC.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/24.
//

import UIKit

class TimetableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var weekDayList: [UIButton]!
    
    var array: [Any] = []
    
    var week : [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var selIndex = 0
    
    // 规划为 周一至周日
    var mondayList: [ModelBase] = []
    var tuesdayList: [ModelBase] = []
    var wednesdayList: [ModelBase] = []
    var thursdayList: [ModelBase] = []
    var fridayList: [ModelBase] = []
    var saturdayList: [ModelBase] = []
    var sundayList: [ModelBase] = []
    
    
    func courseSet() {
        var courseModel = CourseTimetableModel()
        
        for strWeek in week {
            var sundayList1 = CourseDataManage.selNote(courseStr: strWeek)
            for   courModel in sundayList1 {
                var courseTimeArray = CourseDataTimeManager.selNoteAll(superTime: courModel.time!)
                
                courseModel.courstModel = courModel
                var timeArray:[CourseTimeTable] = []
                for timeModel in courseTimeArray {
                    if (timeModel.dayWeek! == strWeek) {
                        timeArray.append(timeModel)
                    }
                }
                courseModel.courstTimeArray = timeArray
                
                courseModel.time = "0000-00-00"
                if strWeek == "Monday" {
                    mondayList.append(courseModel)
                }else if strWeek == "Tuesday" {
                    tuesdayList.append(courseModel)
                }else if strWeek == "Wednesday" {
                    wednesdayList.append(courseModel)
                }else if strWeek == "Thursday" {
                    thursdayList.append(courseModel)
                }else if strWeek == "Friday" {
                    fridayList.append(courseModel)
                }else if strWeek == "Saturday" {
                    saturdayList.append(courseModel)
                }else if strWeek == "Sunday" {
                    sundayList.append(courseModel)
                }
                
             }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        courseSet()
        
        var activitiesArray = AcivitesDataManage.getNote()
        //        var courseArray = CourseDataManage.getNote()
        var homeworkArray = HomeworkDataManage.getNote()
        var examsArray = ExamsDataManage.getNote()
        
        
         
        fenWithWeek(array: activitiesArray)
        //        fenWithWeek(array: courseArray)
        fenWithWeek(array: homeworkArray)
        fenWithWeek(array: examsArray)
        
        // 在排序一下
        let mondayList1 = mondayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        mondayList = mondayList1;
        
        
        let tuesdayList1 = tuesdayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        tuesdayList = tuesdayList1;
        
        let wednesdayList1 = wednesdayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        wednesdayList = wednesdayList1;
        
        let thursdayList1 = thursdayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        thursdayList = thursdayList1;
        
        let fridayList1 = fridayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        fridayList = fridayList1;
        
        let saturdayList1 = saturdayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        saturdayList = saturdayList1;
        
        let sundayList1 = sundayList.sorted { model1, model2 in
            return model1.time! < model2.time!
            
        }
        sundayList = sundayList1;
        
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.register(UINib(nibName: "CoursesCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "TimetableCell", bundle: nil), forCellReuseIdentifier: "cell1")
        
        tableView.reloadData()
        
        let btn = weekDayList[selIndex]
        for button in weekDayList {
            button.backgroundColor = UIColor.gray
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        btn.backgroundColor = UIColor(red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
    func dayWithWeek(str: String) -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: str)
        let stt = date!.weekDay()
        return stt
    }
    
    func fenWithWeek(array: [ModelBase]) {
        for  model in array {
            let weekStr = dayWithWeek(str: (model as! ModelBase).time!)
            if weekStr == "Monday" {
                mondayList.append(model)
            }else if weekStr == "Tuesday" {
                tuesdayList.append(model)
            }else if weekStr == "Wednesday" {
                wednesdayList.append(model)
            }else if weekStr == "Thursday" {
                thursdayList.append(model)
            }else if weekStr == "Friday" {
                fridayList.append(model)
            }else if weekStr == "Saturday" {
                saturdayList.append(model)
            }else if weekStr == "Sunday" {
                sundayList.append(model)
            }
        }
        
    }
    
    func selWithArray() -> Array<ModelBase> {
        if (selIndex == 0) {
            return mondayList
        }else if (selIndex == 1) {
            return tuesdayList
        } else if (selIndex == 2) {
            return wednesdayList
        }else if (selIndex == 3) {
            return thursdayList
        }else if (selIndex == 4) {
            return fridayList
        }else if (selIndex == 5) {
            return saturdayList
        }
        return sundayList
    }
    
    @IBAction func selWeekAction(_ sender: UIButton) {
        selIndex = sender.tag
        
        let btn = weekDayList[selIndex]
        for button in weekDayList {
            button.backgroundColor = UIColor.gray
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        btn.backgroundColor = UIColor(red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        
        tableView.reloadData()
        
    }
    
    
}

extension TimetableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selWithArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = selWithArray()[indexPath.row]
        if (model is CourseTimetableModel) {
            let cell: CoursesCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoursesCell
            cell.selectionStyle = .none
            
            var courseModel:CourseTimetableModel  = model as! CourseTimetableModel
            cell.courseNameLabel.text = courseModel.courstModel?.subject
            cell.instructorLabel.text = courseModel.courstModel?.details
            cell.classroomLabel.text = courseModel.courstModel?.roomStr
            
            
            var str = ""
            if (courseModel.courstTimeArray?.count ?? 0 > 0) {
                for timeModel:CourseTimeTable in courseModel.courstTimeArray! {
                    str.append("\(timeModel.dayTime!),")
                }
                
                cell.courseTimeLabel.text = str
            }
            
            
            return cell
        }
        
        let cell: TimetableCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TimetableCell
        cell.selectionStyle = .none
        cell.subjectLabel.text = model.subject ?? ""
        cell.detailsLabel.text = model.details ?? ""
        cell.deadlineLabel.text = (model.time?.timeWitMoonTime())
        
        if (model is ExamsTable) {
            cell.titLabel.text = "Exams"
        }else if (model is AcivitesTable) {
            cell.titLabel.text = "Activites"
        }else if (model is HomeworkTable) {
            cell.titLabel.text = "Homework"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = selWithArray()[indexPath.row]
        if (model is CourseTimetableModel) {
            return 120
        }else {
            return 150
        }
    }
    
}
