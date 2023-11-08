//
//  BHomeViewController.swift
//  ios_notepad
//
//  Created by LXie on 15/8/2023.
//

import UIKit

class BHomeViewController: UIViewController {

    @IBOutlet var coursesLabel: UILabel!
    @IBOutlet var homeworkLabel: UILabel!
    @IBOutlet var examsLabel: UILabel!
    @IBOutlet var activitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var activitiesArray = AcivitesDataManage.getNote()
        var courseArray = CourseDataManage.getNote()
        var homeworkArray = HomeworkDataManage.getNote()
        var examsArray = ExamsDataManage.getNote()
        
        if (activitiesArray.count < 1) {
            activitiesLabel.text = "Nothing Added"
        }else {
            activitiesLabel.text = "You have \(activitiesArray.count) activities in total"
        }
        
        if (courseArray.count < 1) {
            coursesLabel.text = "Nothing Added"
        }else {
            coursesLabel.text = "You have \(courseArray.count) course in total"
        }
        
        if (homeworkArray.count < 1) {
            homeworkLabel.text = "Nothing Added"
        }else {
            homeworkLabel.text = "You have \(homeworkArray.count) homework in total"
        }
        
        if (examsArray.count < 1) {
            examsLabel.text = "Nothing Added"
        }else {
            examsLabel.text = "You have \(examsArray.count) exams in total"
        }
    }
    
    
    @IBAction func coursesAction(_ sender: Any) {
        var vc = CourseInfoViewController()

        vc.saveBlock =  { [weak self] in
 
            var courseArray = CourseDataManage.getNote()
              
            if (courseArray.count < 1) {
                self?.coursesLabel.text = "Nothing Added"
            }else {
                self?.coursesLabel.text = "You have \(courseArray.count) course in total"
            }
            
        }
        present(vc, animated: true)
    }
    
    
    @IBAction func homeworkAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3;
    }
    
    @IBAction func examsAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 4;

    }
    
    @IBAction func activitesAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1;
    }
    
    
    @IBAction func exitAction(_ sender: Any) {
        let alertVC:UIAlertController = UIAlertController (title: "Title", message: "log out", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Sure", style: .default) { UIAlertAction in
            UserDefaults.standard.set("0", forKey: String.loginSuccess)
            UserDefaults.standard.synchronize()
            let window:UIWindow = (UIApplication.shared.delegate?.window)!!
            let nav = UINavigationController(rootViewController: LoginVC())
            window.rootViewController = nav
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertVC.addAction(defaultAction)
        alertVC.addAction(cancel)

        self.present(alertVC, animated: true, completion: nil)
        
        
       
    }
    
}
