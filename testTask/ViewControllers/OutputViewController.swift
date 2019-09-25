//
//  OutputViewController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {
    var toPass: String! = UserDefaults.standard.object(forKey: "myKey") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
         button.backgroundColor = .green
         button.setTitle("Test Button", for: .normal)
         self.view.addSubview(button)
          button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    @objc func buttonAction(sender: UIButton!) {
        print(toPass)
    }

}
