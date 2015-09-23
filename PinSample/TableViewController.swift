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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        ClientModel.sharedInstance().getStudentLocations({ self.tableView.reloadData() })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postTableViewCell") as! UITableViewCell
        let locations = ClientModel.sharedInstance().locations
        let post = locations[indexPath.row]
        cell.textLabel?.text = (post["firstName"] as! String) + " " + (post["lastName"] as! String)
        cell.detailTextLabel?.text = post["mediaURL"] as? String
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientModel.sharedInstance().locations.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication()
        let url = tableView.cellForRowAtIndexPath(indexPath)?.detailTextLabel!.text
        app.openURL(NSURL(string: url!)!)
    }

}
