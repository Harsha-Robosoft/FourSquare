//
//  ForgotPasswordNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation
class ForgotPasswordNetwork {
    
//    func ForgotPassword(email: String, password: String, completion: @escaping((Bool,Error?) -> ())) {
//        
//        guard let url = URL(string:"https://four-square-three.vercel.app/api/forgotPassword") else{ return }
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
//                    print("Register Error is: \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                if let responsIs = responce as? HTTPURLResponse{
//                    print("Register responce : ",responsIs.statusCode)
//                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
//                        do{
//                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                                completion(true,nil)
//                        }
//                    }else if responsIs.statusCode == 400{
//                        
//                        completion(false,error)
//
//                    }else{
//                        completion(false,error)
//                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
//                    }
//                }
//            })
//        task.resume()
//    }
}
