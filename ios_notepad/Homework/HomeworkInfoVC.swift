//
//  HomeworkInfoVC.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/24.
//

import UIKit

class HomeworkInfoVC: UIViewController {
    
    var array : [HomeworkTable]!

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        array = HomeworkDataManage.getNote()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeworkInfoCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
    }

    @IBAction func gotoAction(_ sender: Any) {
        var vc = HomeworkViewController()
        vc.saveBlock =  { [weak self] in
            self?.array = HomeworkDataManage.getNote()
            self?.tableView.reloadData()
        }
        present(vc, animated: true)
     }
    

}


extension HomeworkInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: HomeworkTable = array[indexPath.row]
        var cell: HomeworkInfoCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeworkInfoCell
        cell.selectionStyle = .none
        cell.subjectLabel.text = model.subject ?? ""
        cell.detailsLabel.text = model.details ?? ""
        cell.deadlineLabel.text = "Deadline:" + (model.time ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: HomeworkTable = array[indexPath.row]
        var vc = HomeworkViewController()
        vc.model = model
        present(vc, animated: true)
        
        vc.saveBlock =  { [weak self] in
            self?.array = HomeworkDataManage.getNote()
            self?.tableView.reloadData()
        }

        
    }
}
