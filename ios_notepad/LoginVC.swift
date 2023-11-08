//
//  LoginVC.swift
//  ios_notepad
//
//  Created by zsm on 2022/10/30.
//

import UIKit

extension String {
    static let phone = "phone"
    static let password = "password"
    static let loginSuccess = "loginSuccess"
    static let time = ""
}

class LoginVC: UIViewController {

    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "登录"
        // Do any additional setup after loading the view.
        
        loginBtn.layer.cornerRadius = 22.5
        loginBtn.layer.masksToBounds = true
    }

    
    @IBAction func touchToLogin(_ sender: Any) {
        var phoneStr: String = UserDefaults.standard.string(forKey: String.phone) ?? ""
        var passwordStr: String = UserDefaults.standard.string(forKey: String.password) ?? ""
        
        let title = self.phoneTF.text
        let pwdStr = self.pwdTF.text
        if (title?.count == 0) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Please enter your account number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        if (pwdStr?.count == 0) {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Please enter password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
    
        
        if phoneStr.count == 0 {
            let alertVC:UIAlertController = UIAlertController (title: "Title", message: "The account does not exist, please register first", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Sure", style: .default) { UIAlertAction in
                let resignVC = ResignVC()
                self.navigationController?.pushViewController(resignVC, animated: true)
            }
            alertVC.addAction(defaultAction)
            self.present(alertVC, animated: true, completion: nil)
        }else{
            if title == phoneStr && pwdStr == passwordStr {
                loginSuccess()
            }else if title == phoneStr && pwdStr != passwordStr{
                let alertVC:UIAlertController = UIAlertController (title: "Title", message: "Password error", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
                alertVC.addAction(defaultAction)
                self.present(alertVC, animated: true, completion: nil)
            }else{
                let alertVC:UIAlertController = UIAlertController (title: "Title", message: "The account does not exist, please register first", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Sure", style: .default, handler: nil)
                alertVC.addAction(defaultAction)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func touchToResign(_ sender: Any) {
        let resignVC = ResignVC()
        self.navigationController?.pushViewController(resignVC, animated: true)
//        self.present(resignVC, animated: true, completion: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set("0", forKey: String.loginSuccess)
        UserDefaults.standard.synchronize()
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false;
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
