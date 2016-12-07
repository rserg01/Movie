//
//  SignInService.swift
//  movie
//
//  Created by Reginald Sergio on 12/7/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import Foundation

protocol SignInServiceDelegate : class {
    
    func signInCompleted()
    func signInInProgress()
    func signInFailed(error : String?)
}

class SignInService {
    
    static let sharedInstance = SignInService()
    
    //Define server side URL
    let REGISTRATION_URL = "http://demo.iloilo.cityserv.oneserv.ph/api/auth/login.json"
    let REGISTRATION_API_TOKEN = "base64:Lhp1BB3ms7WVgXBKbOkSmDQaIYlCQu/sXfV1Tp2woR0="
    
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    
    func postSignIn(siginDetails:LoginModel, delegate:SignInServiceDelegate) {
        
        delegate.signInInProgress()
        
        let urlComponents = NSURLComponents(string: REGISTRATION_URL)!
        
        urlComponents.queryItems = [
            NSURLQueryItem(name: "api_token", value: REGISTRATION_API_TOKEN),
            NSURLQueryItem(name: "username", value: siginDetails.username),
            NSURLQueryItem(name: "password", value: siginDetails.password)
        ]
        
        let url = urlComponents.URL!
        
        var payload : [String:AnyObject] = [:]
        payload["api_token"] = REGISTRATION_API_TOKEN
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        // Excute HTTP Request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary {
                    
                    if convertedJsonIntoDict["status_code"] as? String == "AUTH_INVALID" {
                        //invalid input
                        print(convertedJsonIntoDict["errors"])
                        delegate.signInFailed(convertedJsonIntoDict["msg"] as? String)
                    } else {
                        //success
                        delegate.signInCompleted()
                    }
                    
                } else {
                    //network failure
                    delegate.signInFailed("Network not responding")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    
}
