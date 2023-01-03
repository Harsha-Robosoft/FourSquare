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
    func sendOtpApiCall(emailToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfOtpVarificationNetwork.sendOtp(email: emailToSend){ otpStatus, otpError in
            DispatchQueue.main.async {
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
    
    
    func varifyOtpApicall(otpIs: String, completion: @escaping((Bool) -> ())) {
        objectOfOtpVarificationNetwork.verifyOtp(otp: otpIs){ varifyStatus, varifyError in
            DispatchQueue.main.async {
                if varifyError == nil{
                    
                    if varifyStatus == true{
                        
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
    
    
    func chekMailIdIsValidApiCall(emailIs: String, completion: @escaping((Bool) -> ())) {
        objectOfOtpVarificationNetwork.chechEmailIsValid(email: emailIs){ validStatus, validError in
            DispatchQueue.main.async {
                if validError == nil{
                    
                    if validStatus == true{
                        
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
    
}
