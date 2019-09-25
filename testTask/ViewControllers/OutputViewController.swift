//
//  OutputViewController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {
    
    var toPass:String!{
        return(UserDefaults.standard.object(forKey: "myKey") as! String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
         button.backgroundColor = .green
         button.setTitle("Test Button", for: .normal)
         self.view.addSubview(button)
          button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        let network = NetworkService()
        network.request(searchTerm: "a=get_entries&session=\(toPass!)") { (data, error) in
            let product = self.decodeJSON(type: SessionModel.self, from: data)
            //print("a=get_entries session=\(self.Session!)")
            //print(product)
        }
        
    }
    @objc func buttonAction(sender: UIButton!) {
        print(toPass)
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
