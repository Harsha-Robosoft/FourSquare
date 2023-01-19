//
//  loginVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class LoginViewModel {
    
    var apiResponce = ApiResponce()
    var objectOfUserDefaults = UserDefaults()
    static var objectOfVm = LoginViewModel()
    var objectOfRegisterNetwork = RegisterNetwork()
    
    func apiCallForUserLogin(emailToSend: String, passwordToSend: String, completion: @escaping((String,Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/login") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": emailToSend,
            "password": passwordToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion("Error while login pleace check again your Email or Password and try again. If you are new here pleace register first.",false)
                    return
                }
                if let parsing1 = data as? [String: Any] {
                    guard let token = parsing1["access_token"] as? String else{ print("No access token")
                        completion("No token",false)
                        return}
                    guard let  tokenInfo =  token.data(using: .utf8) else {print("tokenData error3");return}
                    guard let userIdIs = parsing1["userId"] as? String else{ print("No user Id")
                        completion("No user Id",false)
                        return
                    }
                    let objectOfKeyChain = KeyChain()
                    objectOfKeyChain.saveData(userId: userIdIs, data: tokenInfo)
                    self.objectOfUserDefaults.setValue(userIdIs, forKeyPath: "userId")
                    self.objectOfUserDefaults.setValue(1, forKey: "SignIn")
                    self.objectOfUserDefaults.setValue(4, forKey: "SkipStatus")
                    if (parsing1["message"] as? String) != nil{
                        completion("Success", true)
                    }
                }
            }
        }
        
/*        objectOfRegisterNetwork.loginApiCall(email: emailToSend, password: passwordToSend){ loginData, loginStatus, loginError in
            DispatchQueue.main.async {
                if loginError == nil{
                    if loginStatus == true{
                        if let parsing1 = loginData{
                            guard let token = parsing1["access_token"] as? String else{ print("No access token")
                                completion("No token",false)
                                return}
                            guard let  tokenInfo =  token.data(using: .utf8) else {print("tokenData error3");return}
                            guard let userIdIs = parsing1["userId"] as? String else{ print("No user Id")
                                completion("No user Id",false)
                                return
                            }
                            let objectOfKeyChain = KeyChain()
                            objectOfKeyChain.saveData(userId: userIdIs, data: tokenInfo)
                            self.objectOfUserDefaults.setValue(userIdIs, forKeyPath: "userId")
                            self.objectOfUserDefaults.setValue(1, forKey: "SignIn")
                            self.objectOfUserDefaults.setValue(4, forKey: "SkipStatus")
                            if (parsing1["message"] as? String) != nil{
                                completion("Success", true)
                            }
                        }
                    }else{
                        if loginData != nil{
                            if let parsing1 = loginData{
                                if let parsing2 = parsing1["message"] as? String{
                                    completion(parsing2, false)
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
        } */
    }
}
