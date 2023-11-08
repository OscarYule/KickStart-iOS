//
//  HomeworkViewController.swift
//  ios_notepad
//
//  Created by LXie on 23/8/2023.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    typealias saveAction = () -> Void
    
    var saveBlock: saveAction?
    
    @IBOutlet var titLabel: UILabel!
    
    @IBOutlet var subjectField: UITextField!
    @IBOutlet var detailsField: UITextField!
    @IBOutlet var timeLabel: UILabel!
    
    var timeStr = ""

    var model: AcivitesTable?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (model != nil) {
            titLabel.text = "Edit Activities"
            subjectField.text = model?.subject
            detailsField.text = model?.details
            timeLabel.text = model?.time
        }else {
            var str = Date().getString(format: "yyyy-MM-dd")

            timeStr = str
            timeLabel.text =  timeStr.timeWitMoonTime()
        }
    }
    
    
    
    @IBAction func timeAction(_ sender: Any) {
        let datePicker = YLDatePicker(currentDate: nil, minLimitDate: nil, maxLimitDate: nil, datePickerType: .YMD) { [weak self] (date) in
            var str = date.getString(format: "yyyy-MM-dd")
            
            self?.timeStr = str
            self?.timeLabel.text = self?.timeStr.timeWitMoonTime()

        }
        datePicker.show()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if (subjectField.text?.count  ?? 0 < 1 || detailsField.text?.count  ?? 0 < 1 || timeLabel.text?.count ?? 0 < 1) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "login failure", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        if (model != nil) {
            model!.subject = subjectField.text
            model!.time = timeLabel.text
            model!.details = detailsField.text
            AcivitesDataManage.updateNote(note: model!)
        }else {
            var noteTable = AcivitesTable()
            noteTable.subject = subjectField.text
            noteTable.time = timeStr
            noteTable.details = detailsField.text
            AcivitesDataManage.addNote(note:noteTable)
        }
        
        if (saveBlock != nil) {
            saveBlock!()
        }
        
        
        dismiss(animated: true)
    }
    
    
    
}
