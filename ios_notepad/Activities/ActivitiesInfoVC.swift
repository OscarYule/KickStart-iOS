//
//  HomeworkInfoVC.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/24.
//

import UIKit

class ActivitiesInfoVC: UIViewController {
    
    var activitiesArray : [AcivitesTable]!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        activitiesArray = AcivitesDataManage.getNote()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ActivitiesInfoCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }


    @IBAction func gotoAction(_ sender: Any) {
        var vc = ActivitiesViewController()

        vc.saveBlock =  { [weak self] in
            self?.activitiesArray = AcivitesDataManage.getNote()
            self?.tableView.reloadData()
        }
        
        present(vc, animated: true)
    }
    
}

extension ActivitiesInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: AcivitesTable = activitiesArray[indexPath.row]
        var cell: ActivitiesInfoCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivitiesInfoCell
        cell.selectionStyle = .none
        cell.subjectLabel.text = model.subject ?? ""
        cell.detailsLabel.text = model.details ?? ""
        cell.deadlineLabel.text = "Deadline:" + (model.time ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: AcivitesTable = activitiesArray[indexPath.row]
        var vc = ActivitiesViewController()
        vc.model = model
        present(vc, animated: true)
        
        vc.saveBlock =  { [weak self] in
            self?.activitiesArray = AcivitesDataManage.getNote()
            self?.tableView.reloadData()
        }

        
    }
}
