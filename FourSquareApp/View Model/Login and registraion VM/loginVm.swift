//
//  loginVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class LoginViewModel {
    
    var objectOfUserDefaults = UserDefaults()
    static var objectOfVm = LoginViewModel()
    var objectOfRegisterNetwork = RegisterNetwork()
    
    func apiCallForUserLogin(emailIs: String, passwordIs: String, completion: @escaping((String,Bool) -> ())) {
        objectOfRegisterNetwork.loginApiCall(email: emailIs, password: passwordIs){ loginData, loginStatus, loginError in
            DispatchQueue.main.async {
                if loginError == nil{
                    if loginStatus == true{
                        if let data1 = loginData{
                            
                            print("log in data : \(data1)")
                            guard let token = data1["access_token"] as? String else{ print("No access token")
                                completion("No token",false)
                                return}
                            guard let  tokenInfo =  token.data(using: .utf8) else {print("tokenData error3");return}
                            guard let userIdIs = data1["userId"] as? String else{ print("No user Id")
                                completion("No user Id",false)
                                return
                            }
                            
                            let objectOfKeyChain = KeyChain()
//                            objectOfKeyChain.deletePassword(userId: String(45))
                            objectOfKeyChain.saveData(userId: userIdIs, data: tokenInfo)
                            self.objectOfUserDefaults.setValue(userIdIs, forKeyPath: "userId")
                            self.objectOfUserDefaults.setValue(1, forKey: "SignIn")
                            self.objectOfUserDefaults.setValue(4, forKey: "SkipStatus")
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
