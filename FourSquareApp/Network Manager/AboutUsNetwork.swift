//
//  AboutUsNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class AboutUsNetwork {
    
    func aboutUsApi(completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getAboutUs") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
    
}
