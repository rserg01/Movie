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
    

    @IBAction func signInAction(sender: AnyObject) {
        
        let login = LoginModel(username: usernameTextField.text, password: passwordTextField.text)
        
        SignInService.sharedInstance.postSignIn(login, delegate: self)
    }
    
    
    
    func signInCompleted() {
        
    }
    
    func signInInProgress() {
        showAlertInProgress()
    }
    func signInFailed(error : String?) {
        showAlert(error)
    }
    
    func showAlert(message : String?) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertInProgress() {
        let alertController = UIAlertController(title: "Signing In", message: "Please Wait", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func showAlertSuccessful() {
        let alert = UIAlertController(title: "Sign In", message: "Successul", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

