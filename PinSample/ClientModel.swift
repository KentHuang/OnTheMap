//
//  ClientModel.swift
//  PinSample
//
//  Created by Kent Huang on 9/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

class ClientModel {
    
    var locations = [[String: AnyObject]]()
    var firstName = "Benedict"
    var lastName = "Blacksmith"
    var uniqueID = "99901237786" // hardcoded
    var objectID: String!
    
    func getStudentLocations(completionHandler: () -> Void) {
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
            completionHandler()
        }
        task.resume()
    }
    
    func postStudentLocation(text: String, completionHandler: () -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"\(self.uniqueID)\", \"firstName\": \"\(self.firstName)\", \"lastName\": \"\(self.lastName)\",\"mapString\": \"Statue of Liberty, NY\", \"mediaURL\": \"\(text)\",\"latitude\": 40.6914, \"longitude\": -74.0161}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                println("posting error: \(error)")
                return
            }
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            var parsingError: NSError?
            let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
            // find objectID
            self.objectID = parsedResult.valueForKey("objectId") as! String
            completionHandler()
        }
        task.resume()
    }
    
    func putStudentLocation(text: String, completionHandler: () -> Void) {
        let urlString = "https://api.parse.com/1/classes/StudentLocation/\(self.objectID)"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"\(self.uniqueID)\", \"firstName\": \"\(self.firstName)\", \"lastName\": \"\(self.lastName)\",\"mapString\": \"Statue of Liberty, NY\", \"mediaURL\": \"\(text)\",\"latitude\": 40.6914, \"longitude\": -74.0161}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            completionHandler()
        }
        task.resume()
    }
    
    
    // MARK: - Sample Data
    
//    func hardCodedLocationData() -> [[String : AnyObject]] {
//        return  [
//            [
//                "createdAt" : "2015-02-24T22:27:14.456Z",
//                "firstName" : "Jessica",
//                "lastName" : "Uelmen",
//                "latitude" : 28.1461248,
//                "longitude" : -82.75676799999999,
//                "mapString" : "Tarpon Springs, FL",
//                "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
//                "objectId" : "kj18GEaWD8",
//                "uniqueKey" : 872458750,
//                "updatedAt" : "2015-03-09T22:07:09.593Z"
//            ], [
//                "createdAt" : "2015-02-24T22:35:30.639Z",
//                "firstName" : "Gabrielle",
//                "lastName" : "Miller-Messner",
//                "latitude" : 35.1740471,
//                "longitude" : -79.3922539,
//                "mapString" : "Southern Pines, NC",
//                "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
//                "objectId" : "8ZEuHF5uX8",
//                "uniqueKey" : 2256298598,
//                "updatedAt" : "2015-03-11T03:23:49.582Z"
//            ], [
//                "createdAt" : "2015-02-24T22:30:54.442Z",
//                "firstName" : "Jason",
//                "lastName" : "Schatz",
//                "latitude" : 37.7617,
//                "longitude" : -122.4216,
//                "mapString" : "18th and Valencia, San Francisco, CA",
//                "mediaURL" : "http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
//                "objectId" : "hiz0vOTmrL",
//                "uniqueKey" : 2362758535,
//                "updatedAt" : "2015-03-10T17:20:31.828Z"
//            ]
//        ]
//    }
    
    class func sharedInstance() -> ClientModel {
        struct Singleton {
            static var sharedInstance = ClientModel()
        }
        return Singleton.sharedInstance
    }
    
}