//
//  HomeworkInfoVC.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/24.
//

import UIKit

class ExamsInfoVC: UIViewController {

    var array : [ExamsTable]!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        
        array = ExamsDataManage.getNote()
        tableView.dataSource = self
        tableView.delegate = self
         tableView.register(UINib(nibName: "ExamsInfoCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
    }


    @IBAction func gotoAction(_ sender: Any) {
        var vc = ExamsViewController()

        vc.saveBlock =  { [weak self] in
            self?.array = ExamsDataManage.getNote()
            self?.tableView.reloadData()
        }
        present(vc, animated: true)
    }
    

}

extension ExamsInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: ExamsTable = array[indexPath.row]
        var cell: ExamsInfoCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExamsInfoCell
        cell.selectionStyle = .none
        cell.subjectLabel.text = model.subject ?? ""
        cell.detailsLabel.text = model.details ?? ""
        cell.deadlineLabel.text = "Deadline:" + (model.time?.timeWitMoonTime() ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: ExamsTable = array[indexPath.row]
        var vc = ExamsViewController()
        vc.model = model
        present(vc, animated: true)
        
        vc.saveBlock =  { [weak self] in
            self?.array = ExamsDataManage.getNote()
            self?.tableView.reloadData()
        }

        
    }
}

