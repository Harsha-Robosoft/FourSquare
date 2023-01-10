//
//  AddFavouiretNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class AddFavouiretNetworkManager {
    
    func addFavouiretPlace(token: String, placeid: String, completion: @escaping((Bool,Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addFavourite") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter = [
            "_id": placeid
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
                guard let data = data, error == nil else{
                    print("add favouiret Error is: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responsIs = responce as? HTTPURLResponse{
                    print("add favouiretr responce : ",responsIs.statusCode)
                    if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
                        do{
                            let responsData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        completion(false,error)
                    }else{
                        completion(false,error)
                        print("add favouiret Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
}
