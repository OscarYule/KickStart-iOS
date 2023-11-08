//
//  CourseInfoViewController.swift
//  ios_notepad
//
//  Created by LXie on 23/8/2023.
//

import UIKit

class CourseInfoViewController: UIViewController {
    
    typealias saveAction = () -> Void
    
    var array: [CourseTable] = []
    
    @IBOutlet weak var tableView: UITableView!
    var saveBlock: saveAction?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        CourseDataTimeManager.openDataBase()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        tableView.register(UINib(nibName: "CourseInfoCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        array = CourseDataManage.getNote()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }


 
    @IBAction func gotoAction(_ sender: Any) {
        var vc = CourseViewController()
        vc.saveBlock =  { [weak self] in
            self?.array = CourseDataManage.getNote()
            self?.tableView.reloadData()
            
            
            if (self?.saveBlock != nil) {
                self?.saveBlock!()
            }
        }
        
       
        
        present(vc, animated: true)
    }
    
}


extension CourseInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: CourseTable = array[indexPath.row]
        var cell: CourseInfoCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseInfoCell
        cell.selectionStyle = .none
        
        
        
        cell.courseNameLabel.text = model.subject ?? ""
        cell.instructorLabel.text = model.details ?? ""
        
        var list =  CourseDataTimeManager.selNoteAll(superTime: model.time!)
        var str = ""
        for mod: CourseTimeTable in list {
            str.append(contentsOf: (mod.dayWeek! + " at " + mod.dayTime!) + "\n")
        }
        cell.timeLabel.text = str
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: CourseTable = array[indexPath.row]
        var vc = CourseViewController()
        vc.model = model
        present(vc, animated: true)
        
        vc.saveBlock =  { [weak self] in
            self?.array = CourseDataManage.getNote()
            self?.tableView.reloadData()
            
            if (self?.saveBlock != nil) {
                self?.saveBlock!()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var model: CourseTable = array[indexPath.row]
         
      var list =  CourseDataTimeManager.selNoteAll(superTime: model.time!)
        return CGFloat(65 + list.count * 20)
    }
}
