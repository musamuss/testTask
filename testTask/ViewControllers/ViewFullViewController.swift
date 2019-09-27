//
//  ViewFullViewController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

class ViewFullViewController: UIViewController {
    var label = UILabel()
    var receivedString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         let label = UILabel()
        label.backgroundColor = .green
         label.text = receivedString
        let font = UIFont.systemFont(ofSize: 17.0)
         label.font = font
         label.numberOfLines = 0;
        label.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        self.view.addSubview(label)
        view.backgroundColor  = .gray
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
