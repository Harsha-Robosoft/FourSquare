//
//  HomeNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
import UIKit
class HomeNetwork {
    
    func callHomeApi(endPoint: String, lat: String, long: String, completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
                
        guard let url = URL(string:"https://four-square-three.vercel.app/api\(endPoint)") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "latitude": lat,
            "longitude": long
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Home 5 screen Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Home 5 screen responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let dataIs = responsData as? [[String: Any]]{
                                completion(dataIs,true,nil)
                            }
                        }
                    }else if responsIs.statusCode == 400{
                        completion(nil,false,error)
                    }else{
                        completion(nil,false,error)
                        print("Register Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
        
    }
    
    func signOutApi(token: String, completion: @escaping((Bool,Error?) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/logout") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("logout Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("logout responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        completion(false,error)
                    }else{
                        completion(false,error)
                        print("logout Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
        
    }
    
    
    func userDetails(token: String, completion: @escaping(([String: Any]?,Bool,Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getProfile") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("user data Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("user data responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let dataIsIs = responsData as? [String:Any]{
                                completion(dataIsIs,true,nil)
                            }
                        }
                    }else if responsIs.statusCode == 400{
                        completion(nil,false,error)
                    }else{
                        completion(nil,false,error)
                        print("user data Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    
    func feedbackApi(token: String, feddBack: String, completion: @escaping((Bool,Error?) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addFeedback") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "feedback": feddBack
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Feedback Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Feedback responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        completion(false,error)
                    }else{
                        completion(false,error)
                        print("Feedback Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    
    func favouiretPlaceIdies(token: String, completion: @escaping(([String: Any]?,Bool,Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getFavouriteId") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("All favouirets Id Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("All favouirets Id responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            let responcedata = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let data0 = responcedata as? [String: Any]{
                                completion(data0,true,nil)

                            }
                        }
                    }else if responsIs.statusCode == 400{
                        completion(nil,false,error)
                    }else{
                        completion(nil,false,error)
                        print("All favouirets Id Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    
    func updateUserProfile(token: String, image: UIImage, completion: @escaping((Bool,Error?) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addProfileImage") else{return}
                        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            let data = NSMutableData()

        let fieldName = "image"
        if let imageData = image.jpegData(compressionQuality: 0.1) {
                data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
                data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8) ?? data as Data)
                data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) ?? data as Data)
                data.append(imageData)
                data.append("\r\n".data(using: .utf8) ?? data as Data)
            }
            data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
            request.httpBody = data as Data
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                    guard let data = data, error == nil else{
                print("Profile Api Error is: \(String(describing: error?.localizedDescription))")
                return
            }
            if let responsIs = responce as? HTTPURLResponse{
                print("Profile api responce",responsIs.statusCode)
                if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                    do{
                        let _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        completion(true,nil)
                    }
                }else if (responsIs.statusCode == 400) {
                    completion(false,error)
                }else{
                    completion(false,error)
                }
            }
        })
        task.resume()
    }
    
}
