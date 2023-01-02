//
//  ForgotPasswordVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation
class ForgotPasswordViewModel {
    
    static var objectOfVm = ForgotPasswordViewModel()
    var objectOfForgotPasswordNetwork = ForgotPasswordNetwork()
    
    func forgotPassewordApiCall(emailIs: String, passwordIs: String, completion: @escaping((Bool) -> ())) {
        objectOfForgotPasswordNetwork.ForgotPassword(email: emailIs, password: passwordIs){ forgotStatus, ForgotError in
            
            if ForgotError == nil{
                
                if forgotStatus == true{
                    
                    completion(true)
                }else{
                    completion(false)
                }
                
            }else{
                completion(false)
                
            }
            
        }
    }
}
