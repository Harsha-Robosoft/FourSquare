//
//  ApiResponce.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 18/01/23.
//

import Foundation
class ApiResponce {
    func apiResonce(requestType: URLRequest, returnResponce: @escaping((Any?,Bool,Error?) -> ())){
        
        print("898",requestType)
        
        URLSession.shared.dataTask(with: requestType) { data, responce, error in
            if let responce = responce as? HTTPURLResponse{
                guard let responceData = data else{ return}
                
                if responce.statusCode == 400 || responce.statusCode == 401{
                    returnResponce(nil,false,error)
                }else if responce.statusCode == 200 || responce.statusCode == 201{
                    let responceData = try? JSONSerialization.jsonObject(with: responceData, options: .mutableContainers)
                    print(responceData)
                    returnResponce(responceData,true,nil)
                }else{
                    returnResponce(nil,false,error)
                }
            }
            
            if error != nil{
                print("hi hi ")
            }
        }.resume()
    }
}
