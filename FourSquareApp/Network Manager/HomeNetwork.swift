//
//  HomeNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
class HomeNetwork {
    
    func callHomeApi(endPoint: String, lat: String, long: String, completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
        
//        print("end point : \(endPoint)\nlat : \(lat)\nlong : \(long)")
        
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
                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
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
    
    
}
