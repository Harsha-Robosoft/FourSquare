//
//  loginVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class LoginViewModel {
    
    static var objectOfVm = LoginViewModel()
    var objectOfRegisterNetwork = RegisterNetwork()
    
    func apiCallForUserLogin(emailIs: String, passwordIs: String, completion: @escaping((String,Bool) -> ())) {
        objectOfRegisterNetwork.loginApiCall(email: emailIs, password: passwordIs){ loginData, loginStatus, loginError in
            DispatchQueue.main.async {
                if loginError == nil{
                    if loginStatus == true{
                        if let data1 = loginData{
                            if let data2 = data1["message"] as? String{
                                completion("Success", true)
                            }
                        }
                    }else{
                        if loginData != nil{
                            if let data1 = loginData{
                                if let data2 = data1["message"] as? String{
                                    completion(data2, false)
                                }
                            }
                        }else{
                            completion("Error while loging...!", false)
                        }
                    }
                }else{
                    completion("Error...!",false)
                }
            }
        }
    }
}
