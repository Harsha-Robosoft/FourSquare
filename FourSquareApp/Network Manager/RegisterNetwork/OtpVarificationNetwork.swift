//
//  OtpVarificationNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation
class OtpVarificationNetwork {
    
    func sendOtp(email: String, completion: @escaping((Bool,Error?) -> ())) {
                
        guard let url = URL(string:"https://four-square-three.vercel.app/api/sendOtp") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": email
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Send otp Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Send otp responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        
                        completion(false,error)

                    }else{
                        completion(false,error)
                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    
    func verifyOtp(otp: String, completion: @escaping((Bool,Error?) -> ()))  {
        
        print("otp sending : \(otp)")
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/verifyOtp") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "otp": otp
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Varify otp Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Varify otp responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        
                        completion(false,error)

                    }else{
                        completion(false,error)
                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    func chechEmailIsValid(email: String, completion: @escaping((Bool,Error?) -> ())) {
        
        print("main id sending  : \(email)")
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/emailExists") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": email
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Check mail id is valid Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Check mail id is valid responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        
                        completion(false,error)

                    }else{
                        completion(false,error)
                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
}
    

