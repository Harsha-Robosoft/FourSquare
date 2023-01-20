//
//  RegisterNetowork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class RegisterNetwork {
    
    
//    func registerApiCall(email: String, mabileNumber: String, password: String, completion: @escaping(([String: Any]?,Bool,Error?) -> ())) {
//        
//        guard let url = URL(string:"https://four-square-three.vercel.app/api/register") else{ return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let parameter: [String:Any] = [
//            "email": email,
//            "phoneNumber": mabileNumber,
//            "password": password
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
//                guard let data = data, error == nil else{
//                    print("Register Error is: \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                if let responsIs = responce as? HTTPURLResponse{
//                    print("Register responce : ",responsIs.statusCode)
//                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
//                        do{
//                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                            if let dataIs = responsData as? [String: Any]{
//                                completion(dataIs,true,nil)
//                            }
//                        }
//                    }else if responsIs.statusCode == 400{
//                        do{
//                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                            if let dataIs = responsData as? [String: Any]{
//                                completion(dataIs,false,nil)
//                            }
//                        }
//                    }else{
//                        completion(nil,false,error)
//                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
//                    }
//                }
//            })
//        task.resume()
//    }
//    
//    func loginApiCall(email: String, password: String, completion: @escaping(([String: Any]?,Bool,Error?) -> ())) {
//        
//        guard let url = URL(string:"https://four-square-three.vercel.app/api/login") else{ return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let parameter: [String:Any] = [
//            "email": email,
//            "password": password
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
//                guard let data = data, error == nil else{
//                    print("Login Error is: \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                if let responsIs = responce as? HTTPURLResponse{
//                    print("login responce : ",responsIs.statusCode)
//                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
//                        do{
//                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                            if let dataIs = responsData as? [String: Any]{
//                                completion(dataIs,true,nil)
//                            }
//                        }
//                    }else if responsIs.statusCode == 400{
//                        do{
//                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                            if let dataIs = responsData as? [String: Any]{
//                                completion(dataIs,false,nil)
//                            }
//                        }
//                    }else{
//                        completion(nil,false,error)
//                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
//                    }
//                }
//            })
//        task.resume()
//    }
    
}
