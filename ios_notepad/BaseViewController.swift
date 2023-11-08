//
//  BaseViewController.swift
//  ios_notepad
//
//  Created by xl12 on 2022/11/14.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_white")
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_white")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        let dict = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
             self.navigationController?.navigationBar.titleTextAttributes = dict
            //设置导航栏背景图片为一个空的image，这样就透明了
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
             //去掉透明后导航栏下边的黑边
             self.navigationController?.navigationBar.isTranslucent = true

     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
