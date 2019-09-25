//
//  MainTapBarController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//


import UIKit

class MainTapBarController: UITabBarController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewControllers = [generateNavigationController(rootViewController: OutputViewController(), title: "Output"),generateNavigationController(rootViewController: AddViewController(), title: "Add")]
        
    }

    private func generateNavigationController(rootViewController:UIViewController,title:String)->UIViewController{
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
    
  
  

}
