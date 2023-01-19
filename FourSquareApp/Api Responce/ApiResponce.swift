//
//  ApiResponce.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 18/01/23.
//

import Foundation
class ApiResponce {
    func getApiResonce(request: URLRequest, returnResponce: @escaping((Any?,Bool,Error?) -> ())){
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
            guard let data = data, error == nil else{
                print("ADD or REMOVE favouiret Error is: \(String(describing: error?.localizedDescription))")
                return
            }
            if let responsIs = responce as? HTTPURLResponse{
                print("ADD or REMOVE favouiretr responce : ",responsIs.statusCode)
                if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                    do{
                        let responseDat = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        returnResponce(responseDat,true,nil)
                    }
                }else if responsIs.statusCode == 400{
                    returnResponce(nil,false,error)
                }else{
                    returnResponce(nil,false,error)
                    print("ADD or REMOVE favouiret Error is: ", error?.localizedDescription ?? "Error...?")
                }
            }
        })
    task.resume()
    }
    
    func postApiResonce(request: URLRequest, returnResponce: @escaping((Any?,Bool,Error?) -> ())){
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
            guard let data = data, error == nil else{
                print("ADD or REMOVE favouiret Error is: \(String(describing: error?.localizedDescription))")
                return
            }
            if let responsIs = responce as? HTTPURLResponse{
                print("ADD or REMOVE favouiretr responce : ",responsIs.statusCode)
                if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                    do{
                        let responseDat = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        returnResponce(responseDat,true,nil)
                    }
                }else if responsIs.statusCode == 400{
                    returnResponce(nil,false,error)
                }else{
                    returnResponce(nil,false,error)
                    print("ADD or REMOVE favouiret Error is: ", error?.localizedDescription ?? "Error...?")
                }
            }
        })
    task.resume()
    }
    
    func postFormdatApiResonce(request: URLRequest, returnResponce: @escaping((Any?,Bool,Error?) -> ())){
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
            guard let data = data, error == nil else{
                print("ADD or REMOVE favouiret Error is: \(String(describing: error?.localizedDescription))")
                return
            }
            if let responsIs = responce as? HTTPURLResponse{
                print("ADD or REMOVE favouiretr responce : ",responsIs.statusCode)
                if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                    do{
                        let responseDat = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        returnResponce(responseDat,true,nil)
                    }
                }else if responsIs.statusCode == 400{
                    returnResponce(nil,false,error)
                }else{
                    returnResponce(nil,false,error)
                    print("ADD or REMOVE favouiret Error is: ", error?.localizedDescription ?? "Error...?")
                }
            }
        })
    task.resume()
    }
}
