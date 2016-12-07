//
//  ViewController.swift
//  movie
//
//  Created by Reginald Sergio on 11/10/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SignInServiceDelegate {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushRegistration(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RegistrationViewController") as! RegistrationViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
    }
    
    func signInCompleted() {
        
    }
    
    func signInInProgress() {
        
    }
    func signInFailed(error : NSError) {
        
    }
}

