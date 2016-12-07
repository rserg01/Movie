//
//  RegistrationModel.swift
//  movie
//
//  Created by Reginald Sergio on 12/7/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import UIKit

class Registration: NSObject {
    
    let firstName : String?
    let lastName : String?
    let email : String?
    let contactNumber : String?
    let password : String?
    let confirmPassword : String?
    
    init(firstName:String?, lastName:String?, email:String?, contactNumber:String?, password:String?, confirmPassword:String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contactNumber = contactNumber
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
