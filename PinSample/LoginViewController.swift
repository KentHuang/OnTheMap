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
        
        self.loginButton.delegate = self
        self.loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "user_friends"];
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            println("There was an error: \(error)")
        } else {
            
            if (FBSDKAccessToken.currentAccessToken() != nil) {
                FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler { connection, result, error in
                    if error == nil {
                        println(result)
                    }
                }
            }
            
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        return
    }

}

