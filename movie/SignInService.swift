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
    func signInFailed(error : NSError)
}

class SignInService {
    
    static let sharedInstance = RegistrationService()
    
    //Define server side URL
    let REGISTRATION_URL = "http://demo.iloilo.cityserv.oneserv.ph/api/auth/register.json"
    let REGISTRATION_API_TOKEN = "base64:Lhp1BB3ms7WVgXBKbOkSmDQaIYlCQu/sXfV1Tp2woR0="
    
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    
    func postRegistration(registration:Registration) {
        let urlComponents = NSURLComponents(string: REGISTRATION_URL)!
        
        urlComponents.queryItems = [
            NSURLQueryItem(name: "api_token", value: REGISTRATION_API_TOKEN),
            NSURLQueryItem(name: "fname", value: registration.firstName),
            NSURLQueryItem(name: "lname", value: registration.lastName),
            NSURLQueryItem(name: "email", value: registration.email),
            NSURLQueryItem(name: "contact_number", value: registration.contactNumber),
            NSURLQueryItem(name: "password", value: registration.password),
            NSURLQueryItem(name: "password_confirmation", value: registration.confirmPassword)
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
                    
                    
                    
                    if convertedJsonIntoDict.allKeys.count > 0 {
                        // Print out dictionary
                        print(convertedJsonIntoDict)
                        
                        if convertedJsonIntoDict["errors"]!.allKeys.count > 0 {
                            //invalid input
                            print(convertedJsonIntoDict["errors"])
                        } else {
                            //success
                        }
                        
                    } else {
                        //network failure
                    }
                    
                    // Get value by key
                    if let movieList = convertedJsonIntoDict as? [String: AnyObject] {
                        if let movieDictionary = movieList["results"] as? NSMutableArray {
                            for item in movieDictionary {
                                
                                let title = item["title"] as? String
                                print(title)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    
}
