//
//  MainTapBarController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//


import UIKit

class MainTapBarController: UITabBarController {

    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    override func viewDidLoad() {
        super.viewDidLoad()
//        if firstRun {
            let network = NetworkService()
            network.request(searchTerm: "a=new_session") { (data, error) in
                let product = self.decodeJSON(type: Session.self, from: data)
                print("data \(product)")
                print("error \(error)")
                
            }
//            print("kek")
//        } else {
//            runFirst() //will only run once
//        }
        
        //view.backgroundColor = .red
        viewControllers = [generateNavigationController(rootViewController: OutputViewController(), title: "Output"),generateNavigationController(rootViewController: AddViewController(), title: "Add"),generateNavigationController(rootViewController: ViewFullViewController(), title: "ViewFull")]
        
    }
    
    private func generateNavigationController(rootViewController:UIViewController,title:String)->UIViewController{
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
    
//MARK: -- создание новой сессии устройства, для каждого пользователя
   private func runFirst() {
    
        print("FIRST RUN!")
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
   func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
    
    
    
}
