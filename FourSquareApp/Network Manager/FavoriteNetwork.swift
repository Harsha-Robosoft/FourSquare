//
//  FavouiretNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//



import Foundation
class FavouiretNetwork {
    
//    func favouiretSearchListFilter(token: String,endPoint: String, paramDictionary: [String: Any], completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
//        guard let url = URL(string:"https://four-square-three.vercel.app/api\(endPoint)") else{ return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let parameter: [String:Any] = paramDictionary
//        
//        print("filter sending :Token \(token)Dic : \(parameter)")
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
//                guard let data = data, error == nil else{
//                    print("Search favouiret Error is: \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                if let responsIs = responce as? HTTPURLResponse{
//                    print("Search favouiretr responce : ",responsIs.statusCode)
//                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
//                        do{
//                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                            if let dataIs = responsData as? [[String: Any]]{
//                                completion(dataIs,true,nil)
//                            }
//                        }
//                    }else if responsIs.statusCode == 400{
//                        completion(nil,false,error)
//                    }else{
//                        completion(nil,false,error)
//                        print("Search favouiret Error is: ", error?.localizedDescription ?? "Error...?")
//                    }
//                }
//            })
//        task.resume()
//    }
}
