//
//  ReviewNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
import UIKit
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
    
    
    func textReviewSubmit(token: String, restaturantId: String, reviewIs: String,completion: @escaping((Bool, Error?) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addReview") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let parameter: [String:Any] = [
            "_id": restaturantId,
            "review": reviewIs
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
                            
                                completion(true,nil)
                        }
                    }else if responsIs.statusCode == 400{
                        completion(false,error)
                    }else{
                        completion(false,error)
                        print("All review Error is: ", error?.localizedDescription ?? "Error...?")
                    }
                }
            })
        task.resume()
    }
    
    func photoReviewSubmit(token: String, placeId: String, image: [UIImage], completion: @escaping((Bool, Error?) -> ())) {
        
        print("Api Data : token\(token)\n\(placeId)\n numnber\(image.count)")
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addReviewImage") else{return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let data = NSMutableData()
        
        let fieldName = "image"
        for i in image{
            if let imageData = i.jpegData(compressionQuality: 0.1) {
                data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
                data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8) ?? data as Data)
                data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) ?? data as Data)
                data.append(imageData)
                data.append("\r\n".data(using: .utf8) ?? data as Data)
            }
        }
            
        let name = "_id"
            data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
            data.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8) ?? data as Data)
            data.append(placeId.data(using: .utf8) ?? data as Data)
            data.append("\r\n".data(using: .utf8) ?? data as Data)
            data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
            request.httpBody = data as Data
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
            guard let data = data, error == nil else{
                print("Photo review Error is: \(String(describing: error?.localizedDescription))")
                return
            }
            if let responsIs = responce as? HTTPURLResponse{
                print("Photo review responce",responsIs.statusCode)
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
