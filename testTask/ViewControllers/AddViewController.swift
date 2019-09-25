//
//  AddViewController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var UserSession:String!{
           return(UserDefaults.standard.object(forKey: "myKey") as! String)
       }
    var UserText:String = "heloooo"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let network = NetworkService()
               network.request(searchTerm: "a=add_entry&session=\(UserSession!)&body=\(UserText)") { (data, error) in
                   let product = self.decodeJSON(type: SessionAddModel.self, from: data)
                   print(product)
               }
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
