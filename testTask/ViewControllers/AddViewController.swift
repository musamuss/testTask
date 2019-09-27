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
    var UserText:String = ""
    var myTextField: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 400.00, height: 600.00));
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        self.view.addSubview(myTextField)

        myTextField.backgroundColor = .white
        myTextField.text = "Enter your text"
        myTextField.translatesAutoresizingMaskIntoConstraints = true
           myTextField.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
           myTextField.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        
        generateButtonSave()
        generateButtonClear()
        
    }
   
    
    //MARK:- функции кнопок
    
    func generateButtonSave(){
        
                let button = UIButton(frame: CGRect(x: 50, y: 750, width: 100, height: 50))
                 button.backgroundColor = .green
                 button.setTitle("Сохранить", for: .normal)
                button.layer.cornerRadius = 20
                button.clipsToBounds = true
                 self.view.addSubview(button)
                  button.addTarget(self, action: #selector(buttonActionSave), for: .touchUpInside)
    }
    
    @objc func buttonActionSave(sender: UIButton!) {
        UserText = myTextField.text
                   let network = NetworkService()
                    network.request(searchTerm: "a=add_entry&session=\(UserSession!)&body=\(UserText)") { (data, error) in
                        let product = self.decodeJSON(type: SessionAddModel.self, from: data)
                        print(product)
                    }
      }
    func generateButtonClear(){
                   let button = UIButton(frame: CGRect(x: 250, y: 750, width: 100, height: 50))
                    button.backgroundColor = .green
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitle("Отменить", for: .normal)
                    self.view.addSubview(button)
                     button.addTarget(self, action: #selector(buttonActionClear), for: .touchUpInside)
       }
       @objc func buttonActionClear(sender: UIButton!) {
        myTextField.text = "Enter your text"
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
