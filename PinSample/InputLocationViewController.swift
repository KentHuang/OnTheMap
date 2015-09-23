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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        if let text = self.linkTextField.text {
            self.postStudentLocation(text)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func postStudentLocation(text: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"Ben\", \"lastName\": \"Chen\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"\(text)\",\"latitude\": 40.6975, \"longitude\": -73.9992}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                println("posting error: \(error)")
                return
            }
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
