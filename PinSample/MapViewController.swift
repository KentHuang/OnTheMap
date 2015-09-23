//
//  MapViewController.swift
//  PinSample
//
//  Created by Jason on 3/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import MapKit
import FBSDKCoreKit
import FBSDKLoginKit

/**
* This view controller demonstrates the objects involved in displaying pins on a map.
*
* The map is a MKMapView.
* The pins are represented by MKPointAnnotation instances.
*
* The view controller conforms to the MKMapViewDelegate so that it can receive a method 
* invocation when a pin annotation is tapped. It accomplishes this using two delegate 
* methods: one to put a small "info" button on the right side of each pin, and one to
* respond when the "info" button is tapped.
*/

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
    var annotations: [MKPointAnnotation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClientModel.sharedInstance().getStudentLocations({ self.drawPins() })
    }
    
    // MARK: - Buttons
    
    @IBAction func logoutButtonPressed(sender: UIBarButtonItem) {
        var manager = FBSDKLoginManager()
        manager.logOut()
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func pinButtonPressed(sender: UIBarButtonItem) {
        
//        for location in self.locations {
//            if (location["uniqueKey"] as! String) == (info["userID"] as! String) {
//                let message = "You have already posted a Student Location. Do you want to overwrite it?"
//                let alertController = UIAlertController(title: "", message: message, preferredStyle: .Alert)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                }
//                alertController.addAction(cancelAction)
//                let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
//                    self.presentInputLocationViewController()
//                }
//                alertController.addAction(yesAction)
//                self.presentViewController(alertController, animated: true, completion: nil)
//            } else {
//                self.presentInputLocationViewController()
//            }
//        }
        
        let newPost = [
            "createdAt" : "2015-03-11T02:48:18.321Z",
            "firstName" : "Jarrod",
            "lastName" : "Parkes",
            "latitude" : 34.73037,
            "longitude" : -86.58611000000001,
            "mapString" : "Huntsville, Alabama",
            "mediaURL" : "https://linkedin.com/in/jarrodparkes",
            "objectId" : "CDHfAy8sdp",
            "uniqueKey" : 996618664,
            "updatedAt" : "2015-03-13T03:37:58.389Z"
        ]
        ClientModel.sharedInstance().locations.append(newPost)
        self.drawPins()
    }
    
    func presentInputLocationViewController() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InputLocationViewController") as! InputLocationViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func drawPins() {
        self.mapView.removeAnnotations(annotations)
        self.annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for dictionary in ClientModel.sharedInstance().locations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
            let long = CLLocationDegrees(dictionary["longitude"] as! Double)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary["firstName"] as! String
            let last = dictionary["lastName"] as! String
            let mediaURL = dictionary["mediaURL"] as! String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
    
    
    // MARK: - MKMapViewDelegate

    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            app.openURL(NSURL(string: annotationView.annotation.subtitle!)!)
        }
    }
    

}