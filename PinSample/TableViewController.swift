//
//  TableViewController.swift
//  PinSample
//
//  Created by Kent Huang on 9/22/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import MapKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var locations = [[String: AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getStudentLocations()
        self.tableView.delegate = self
    }
    
    
    func getStudentLocations() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                println("Error while GETting student locations: \(error)")
                return
            }
            var error: NSError?
            self.locations = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as! NSDictionary).valueForKey("results") as! [[String: AnyObject]]
            println(self.locations)
            self.tableView.reloadData()
        }
        task.resume()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postTableViewCell") as! UITableViewCell
        let post = self.locations[indexPath.row]
        cell.textLabel?.text = (post["firstName"] as! String) + " " + (post["lastName"] as! String)
        cell.detailTextLabel?.text = post["mediaURL"] as? String
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication()
        let url = tableView.cellForRowAtIndexPath(indexPath)?.detailTextLabel!.text
        app.openURL(NSURL(string: url!)!)
    }

}
