//
//  AppDelegate.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 var sessionKey: String?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
          if launchedBefore  {
              print("Not first launch.")
            
          } else {
               let network = NetworkService()
               network.request(searchTerm: "a=new_session") { (data, error) in
               let product = self.decodeJSON(type: Session.self, from: data)
               self.sessionKey = product?.data.session
               print(self.sessionKey)
               let defaults = UserDefaults.standard
                 let defaultValue = ["myKey" : ""]
                 defaults.register(defaults: defaultValue)
                defaults.set(self.sessionKey, forKey: "myKey")
                defaults.synchronize()
                
          }
       UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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



