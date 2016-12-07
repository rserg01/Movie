//
//  LoginModel.swift
//  CalataDemo
//
//  Created by Reginald Sergio on 12/7/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import Foundation

class LoginModel : NSObject {
    
    let username : String?
    let password : String?
    
    init(username:String?, password:String?) {
        self.username = username
        self.password = password
    }
}