//
//  PlaceDetailsNetworkManager.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class PlaceDetailsNetworkManager {
    
//    func particularPlaceDetails(placeIs: String, completion: @escaping(([String: Any]?,Bool,Error?) -> ())) {
//        
//        guard let url = URL(string:"https://four-square-three.vercel.app/api/getParticularPlace") else{ return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let parameter: [String:Any] = [
//            "_id": placeIs
//        ]
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
//                            if let dataIs = responsData as? [String: Any]{
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
//    
//    
//    func addRating(token: String, _Id: String, rating: Int, completion: @escaping((Bool, Error?) -> ())) {
//        guard let url = URL(string:"https://four-square-three.vercel.app/api/addRating") else{ return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let parameter: [String:Any] = [
//            "_id": _Id,
//            "rating": rating
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
//                guard let data = data, error == nil else{
//                    print("rating Error is: \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                if let responsIs = responce as? HTTPURLResponse{
//                    print("rating responce : ",responsIs.statusCode)
//                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
//                        do{
//                            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                                completion(true,nil)
//                        }
//                    }else if responsIs.statusCode == 400{
//                        completion(false,error)
//                    }else{
//                        completion(false,error)
//                        print("rating Error is: ", error?.localizedDescription ?? "Error...?")
//                    }
//                }
//            })
//        task.resume()
//    }
}
