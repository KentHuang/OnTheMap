//
//  LoginViewController.swift
//  PinSample
//
//  Created by Kent Huang on 9/21/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginButton.delegate = self
        self.loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "user_friends"];
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            println("There was an error: \(error)")
        } else {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        return
    }

}

