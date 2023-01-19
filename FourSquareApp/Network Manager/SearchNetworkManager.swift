//
//  SearchNetworkManager.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 05/01/23.
//

import Foundation
class SearchNetworkManager {
    
    func callNearCityApi(lat: String, long: String, completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getNearCity") else{ return }
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
                    print("Nearcity Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Nearcity responce : ",responsIs.statusCode)
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
                        print("Nearcity Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    func searchApicalling(Token: String,lat: String,long: String,tesxtToSend: String, completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
                
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/filterSearch") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "latitude": lat,
            "longitude": long,
            "text": tesxtToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Searching Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Searching responce : ",responsIs.statusCode)
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
                        print("Searching Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    
    func searchWithFilter(Token: String,paramDictionary: [String: Any], completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/filterSearch") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = paramDictionary
        
//        print("filter sending :\nToken \(Token)\nDic : \(parameter)")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("Searching with filter Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("Searching with filter responce : ",responsIs.statusCode)
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
                        print("Searching with filter Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
}
    
