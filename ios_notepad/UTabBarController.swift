//
//  UTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    var open: Bool = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
         AcivitesDataManage.openDataBase()
         CourseDataManage.openDataBase()
         HomeworkDataManage.openDataBase()
         ExamsDataManage.openDataBase()
         CourseDataTimeManager.openDataBase()
        
        addChildViewController(BHomeViewController(),
                               title: "Home",
                               image: UIImage(systemName: "house"),
                               selectedImage: UIImage(systemName: "house"))
        
         addChildViewController(ActivitiesInfoVC(),
                                title: "Activities",
                                image: UIImage(systemName: "sidebar.squares.leading"),
                                selectedImage: UIImage(systemName: "sidebar.squares.leading"))
         
         addChildViewController(TimetableVC(),
                                title: "Timetable",
                                image: UIImage(systemName: "calendar"),
                                selectedImage: UIImage(systemName: "calendar"))
         
         addChildViewController(HomeworkInfoVC(),
                                title: "Homework",
                                image: UIImage(systemName: "book"),
                                selectedImage: UIImage(systemName: "book"))
         
         addChildViewController(ExamsInfoVC(),
                                title: "Exams",
                                image: UIImage(systemName: "pencil.and.outline"),
                                selectedImage: UIImage(systemName: "pencil.and.outline"))
 
    
     
    
        
    }
    
  
    
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image,
                                                  selectedImage: selectedImage)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        
        let nav = NavigationC(rootViewController: childController)
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            let dict = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            
            appearance.setBackIndicatorImage(UIImage(named: "nav_back_white")?.withRenderingMode(.alwaysOriginal), transitionMaskImage: UIImage(named: "nav_back_white")?.withRenderingMode(.alwaysOriginal))
            
            
            appearance.titleTextAttributes = dict
            appearance.backgroundImage = UIImage()
            appearance.backgroundColor = UIColor.green
            appearance.shadowImage = UIImage()
            appearance.shadowColor = UIColor.clear
            appearance.backgroundEffect = nil
            appearance.largeTitleTextAttributes = dict
            nav.navigationBar.scrollEdgeAppearance = appearance
            nav.navigationBar.standardAppearance = appearance
        }else{
            let navigationBarAppearance = UINavigationBar.appearance()
            navigationBarAppearance.backIndicatorImage = UIImage(named: "nav_back_white")
            navigationBarAppearance.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_white")
            nav.navigationBar.barTintColor = UIColor.green
            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        nav.navigationBar.barTintColor = UIColor.green
        addChild(nav)
    }
    
}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}


 
