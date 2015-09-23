//
//  InputLocationViewController.swift
//  PinSample
//
//  Created by Kent Huang on 9/22/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

class InputLocationViewController: UIViewController {

    @IBOutlet weak var linkTextField: UITextField!
    
    var locations: [[String: AnyObject]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        if let text = self.linkTextField.text {
            ClientModel.sharedInstance().postStudentLocation(text)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
