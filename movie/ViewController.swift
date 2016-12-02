//
//  ViewController.swift
//  movie
//
//  Created by Reginald Sergio on 11/10/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Define server side URL
        let MOVIE_URL = "http://api.themoviedb.org/3/discover/movie"
        let PAGE = "1"
        let API_KEY = "e1024aa7aae73b32cebdc5a4b0922e91"
        
        let urlComponents = NSURLComponents(string: MOVIE_URL)!
        
        urlComponents.queryItems = [
            NSURLQueryItem(name: "api_key", value: API_KEY),
            NSURLQueryItem(name: "page", value: PAGE)
        ]
        
        let url = urlComponents.URL!
        var payload : [String:AnyObject] = [:]
        
        payload["api_key"] = API_KEY
        payload["page"] = PAGE
        
        let request = NSMutableURLRequest(URL: url)
        
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
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    // Get value by key
                    let firstNameValue = convertedJsonIntoDict["userName"] as? String
                    print(firstNameValue!)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

