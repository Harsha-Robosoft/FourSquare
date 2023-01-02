//
//  OtpVarificationVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class OtpvarificationViewModel {
    
    static var objectOfVc = OtpvarificationViewModel()
    var objectOfOtpVarificationNetwork = OtpVarificationNetwork()
    func sendOtp(emailToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfOtpVarificationNetwork.sendOtp(email: emailToSend){ otpStatus, otpError in
            
            if otpError == nil{
                
                if otpStatus == true{
                    
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
