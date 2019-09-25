//
//  MainTapBarController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//


import UIKit

class MainTapBarController: UITabBarController {
    var sessionKey: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = NetworkService()
            network.request(searchTerm: "a=new_session") { (data, error) in
            let product = self.decodeJSON(type: Session.self, from: data)
                self.sessionKey = product?.data.session
            //print("data \(product)")
            //print("error \(error)")
                print(self.sessionKey)
                let defaults = UserDefaults.standard
                defaults.set(self.sessionKey, forKey: "myKey")
                defaults.synchronize()
//MARK: - вызов значения из любой части программы
//                let token = UserDefaults.standard.object(forKey: "myKey")
//                print(token)
        }
        
        viewControllers = [generateNavigationController(rootViewController: OutputViewController(), title: "Output"),generateNavigationController(rootViewController: AddViewController(), title: "Add"),generateNavigationController(rootViewController: ViewFullViewController(), title: "ViewFull")]
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController = segue.destination as? OutputViewController else { return }
        guard let firstNum = self.sessionKey else { return }
        destinationController.toPass = firstNum
    }
    private func generateNavigationController(rootViewController:UIViewController,title:String)->UIViewController{
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
    
  //MARK: -- декод JSON
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
