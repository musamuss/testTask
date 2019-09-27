//
//  ViewFullViewController.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit
@IBDesignable
class ViewFullViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var thePropertyYouWantToSet = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = thePropertyYouWantToSet
        label.text?.removeFirst(16)
         label.numberOfLines = 0;
    }
    


}
extension NSAttributedString {
  func height(withConstrainedWidth width: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)

    return ceil(boundingBox.height)
  }

  func width(withConstrainedHeight height: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

    return ceil(boundingBox.width)
  }
}


extension String {
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

    return ceil(boundingBox.height)
  }

  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

    return ceil(boundingBox.width)
  }
}
