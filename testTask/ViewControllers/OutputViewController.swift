//
//  OutputViewController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    private var myArray = [String]()
    private var myTableView: UITableView!
    
    
    var toPass:String!{
        return(UserDefaults.standard.object(forKey: "myKey") as? String ?? "no way")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//         button.backgroundColor = .green
//         button.setTitle("Test Button", for: .normal)
//         self.view.addSubview(button)
//          button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
//MARK:- работа с сетью получение записей сессии
        let network = NetworkService()
        network.request(searchTerm: "a=get_entries&session=\(toPass!)") { (data, error) in
            let product = self.decodeJSON(type: SessionModel.self, from: data)
            //print("a=get_entries session=\(self.Session!)")
            //print(product?.data.first)
            for i in (product?.data.first)! {
                //var kek = i.body
               // kek.padding(toLength: 200, withPad: <#T##StringProtocol#>, startingAt: <#T##Int#>)
                self.myArray.append("body=\(i.body),da=\(i.da)")
            }
            
            self.myTableView.reloadData()
            
            print(self.myArray)
        }
       
//MARK: - генерация tablView
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
      
        self.view.addSubview(myTableView)
        
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
//MARK:- функции настроки tableView
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Num: \(indexPath.row)")
    print("Value: \(myArray[indexPath.row])")
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
    cell.textLabel!.text = "\(myArray[indexPath.row])"
    return cell
}

}
