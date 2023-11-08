//
//  NavigationC.swift
//  ios_notepad
//
//  Created by xl12 on 2022/11/12.
//

import UIKit

class NavigationC: UINavigationController, UINavigationBarDelegate {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
        
        customBarButtonItem()
        

    }
    
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        let dict = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes(dict, for: .normal)
         return true
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // 去掉系统默认自带的文字（上一个控制器的title），修改系统默认的样式（一个蓝色的左箭头）为自己的图片
    func customBarButtonItem() {
        
        let backBtns = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBtns
        navigationController?.navigationBar.tintColor = .white
        
        return
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 0.1),
            .foregroundColor: UIColor.clear
        ], for: .normal)
        
        
        
        
        
    }
//    -(void)customBarButtonItem {
//        // 去掉文字
//        // 自定义全局的barButtonItem外观
//        UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
//        // 将文字减小并设其颜色为透明以隐藏
//        [barButtonItemAppearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:0.1], NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
//
//        // 设置图片
//        // 获取全局的navigationBar外观
//        UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//        // 获取原图
//        UIImage *image = [[UIImage imageNamed:@"goBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        // 修改navigationBar上的返回按钮的图片，注意：这两个属性要同时设置
//        navigationBarAppearance.backIndicatorImage = image;
//        navigationBarAppearance.backIndicatorTransitionMaskImage = image;
//    }

}
