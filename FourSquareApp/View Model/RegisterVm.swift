//
//  RegisterVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class RegisterViewModel {
    
    static var objectOfVm = RegisterViewModel()
    var obejctOfRegisterNetwork = RegisterNetwork()
    
    func apiCallForUserRegistration(emailIS: String, mobileNUmberIs: String, passwordIs: String, completion: @escaping((String, Bool) -> ())) {
        obejctOfRegisterNetwork.registerApiCall(email: emailIS, mabileNumber: mobileNUmberIs, password: passwordIs){ completionData, completionStatus, completionError in
            
            DispatchQueue.main.async {
                if completionError == nil{
                    if completionStatus == true{
                        if let data1 = completionData{
                            if let data2 = data1["message"] as? String{
                                completion(data2, true)
                            }
                        }
                    }else{
                        if completionData != nil{
                            if let data1 = completionData{
                                if let data2 = data1["message"] as? String{
                                    completion(data2, false)
                                }
                            }
                        }else{
                            completion("Error while creating account...!", false)
                        }
                    }
                }else{
                    completion("Error...!",false)
                }
            }
        }
    }
}
