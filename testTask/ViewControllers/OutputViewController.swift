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
    private let refreshControl = UIRefreshControl()
    var toPass:String!{
        return(UserDefaults.standard.object(forKey: "myKey") as? String ?? "no way")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
           let alert = UIAlertController(title: "Нет интренета", message: "Рекоментуем проверить соединение.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Обновить данные", style: .default, handler: {action in
               self.myTableView.reloadData()
               }))
            self.present(alert, animated: true)
        }

        
//MARK:- работа с сетью получение записей сессии
        let network = NetworkService()
        network.request(searchTerm: "a=get_entries&session=\(toPass!)") { (data, error) in
            let product = self.decodeJSON(type: SessionModel.self, from: data)
            for i in (product?.data.first)! {
                
                self.myArray.append("da= \(i.da), body= \(i.body)")
            }
            self.myTableView.reloadData()
            //print(self.myArray)
        }
       
//MARK: - генерация tablView
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        myTableView.refreshControl = refreshControl
        
        self.view.addSubview(myTableView)
    }
   
  
    @objc func refresh(_ refreshControl: UIRefreshControl) {
         let network = NetworkService()
        network.request(searchTerm: "a=get_entries&session=\(toPass!)") { (data, error) in
            let product = self.decodeJSON(type: SessionModel.self, from: data)
            self.myArray.removeAll()
        for i in (product?.data.first)! {
            
            self.myArray.append("da= \(i.da), body= \(i.body)")
        }
            self.myTableView.reloadData()
            self.myTableView.refreshControl?.endRefreshing()
        }
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
    let tableRow = myArray[indexPath.row]
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "kek") as! ViewFullViewController
    vc.thePropertyYouWantToSet = tableRow
    self.navigationController?.pushViewController(vc, animated: true)
    }
    

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myArray.count
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
    cell.textLabel?.numberOfLines = 6
    cell.textLabel!.text = "\(myArray[indexPath.row])"
    return cell
    }
    
   
        
    
}
