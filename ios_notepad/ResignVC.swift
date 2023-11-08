//
//  ResignVC.swift
//  ios_notepad
//
//  Created by zsm on 2022/10/30.
//

import UIKit

class ResignVC: UIViewController {

    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var confirmPwdTF: UITextField!
    
    @IBOutlet weak var resignBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Sign in"
        // Do any additional setup after loading the view.
        
        resignBtn.layer.cornerRadius = 22.5
        resignBtn.layer.masksToBounds = true
        
    }

    @IBAction func clickToResign(_ sender: Any) {
        
        let phoneNo = self.phoneTF.text
        let pwdStr = self.pwdTF.text
        let confirmPwdStr = self.confirmPwdTF.text
        if (phoneNo?.count == 0) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Please fill in the account number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        if (pwdStr?.count == 0) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Please fill in the password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
//
        if let pwd = pwdStr{
            if pwd.count < 6 || pwd.count > 18 {
                let remind = "Please set a password of 6-18 characters"
                let alertVC:UIAlertController = UIAlertController (title: "Title", message: remind, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
                alertVC.addAction(defaultAction)
                self.present(alertVC, animated: true, completion: nil)
                return
            }
        }
        
        if confirmPwdStr != pwdStr{
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "The two passwords are different", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        resignPhoneAndPwd()
    }
    
    
    func resignPhoneAndPwd(){
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = formatter.string(from: nowDate)
        
        let defaults = UserDefaults.standard
        defaults.set(self.phoneTF.text, forKey: String.phone)
        defaults.set(self.pwdTF.text, forKey: String.password)
        defaults.set( date, forKey: String.time)

        defaults.synchronize()
        
        let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Successfully", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Sure", style: .default) { UIAlertAction in
//            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
            
            self.loginSuccess()
        }
        alertVC.addAction(defaultAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func loginSuccess() {
        UserDefaults.standard.set("123", forKey: String.loginSuccess)
        UserDefaults.standard.synchronize()
        
        let defaults = UserDefaults.standard
        var phoneStr: String = UserDefaults.standard.string(forKey: String.phone) ?? ""
        if phoneStr.count == 0   {
            defaults.set(self.phoneTF.text, forKey: String.phone)
            defaults.set(self.pwdTF.text, forKey: String.password)
            defaults.synchronize()
        }
        
        let window:UIWindow = (UIApplication.shared.delegate?.window)!!
        let tab = UTabBarController()
        tab.open = true
        window.rootViewController = tab
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
