//
//  ReviewNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class ReviewNetworkManager {
    
    func Allreviews(token: String, placeId: String, completion: @escaping(([String: Any]?,Bool,Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getReview") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let parameter: [String:Any] = [
            "_id": placeId
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("All review Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("All review responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let dataIs = responsData as? [String: Any]{
                                completion(dataIs,true,nil)
                            }
                        }
                    }else if responsIs.statusCode == 400{
                        completion(nil,false,error)
                    }else{
                        completion(nil,false,error)
                        print("All review Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
}
