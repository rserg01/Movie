//
//  RegistrationViewController.swift
//  movie
//
//  Created by Reginald Sergio on 12/7/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import UIKit

class  RegistrationViewController : UIViewController, RegistrationServiceDelegate {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitRegistation(sender: AnyObject) {
        
        view.endEditing(true)
        
        let registrationDetails = Registration(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text, contactNumber: contactNumberTextField.text, password: passwordTextField.text,confirmPassword: confirmPasswordTextField.text)
        
        RegistrationService.sharedInstance.postRegistration(registrationDetails, delegate: self)
    }
    
    func showAlert(message : String?) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertInProgress() {
        let alertController = UIAlertController(title: "Registration", message: "Please Wait", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func showAlertSuccessful() {
        let alert = UIAlertController(title: "Registration", message: "Successul", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func registrationCompleted() {
        showAlertSuccessful()
    }
    func registrationInProgress() {
        showAlertInProgress()
    }
    func registrationFailed(error : String?) {
        showAlert(error)
    }
}