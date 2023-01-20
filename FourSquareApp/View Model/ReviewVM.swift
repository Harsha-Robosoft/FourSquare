//
//  ReviewVM.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
import UIKit
class ReviewViewModel {
    var apiResponce_Shared = ApiResponce()
    static var _Shared = ReviewViewModel()
    
    var allReviewdata = [ReviewDetails]()
    
    func getAllReviewDataApiCall(tokenToSend: String, placeIdToSend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getReview") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")

        let parameter: [String:Any] = [
            "_id": placeIdToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_Shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                    return
                }
                if let parsing0 = data as? [String: Any]{
                    if parsing0.isEmpty{
                        completion(false)
                    }else{
                        if let parsing1 = parsing0["reviewText"] as? [[String: Any]]{
                            var reviewerId = ""
                            var reviewBy = ""
                            var review = ""
                            var reviewerImage = ""
                            var reviewDate = ""
                            var _id = ""
                            for i in parsing1{
                                if let parsing01 = i["reviewerId"] as? String{
                                    reviewerId = parsing01
                                }
                                if let parsing02 = i["reviewBy"] as? String{
                                    reviewBy = parsing02
                                }
                                if let parsing03 = i["review"] as? String{
                                    review = parsing03
                                }
                                if let parsing04 = i["reviewerImage"] as? String{
                                    reviewerImage = parsing04
                                }
                                if let parsing05 = i["reviewDate"] as? String{
                                    reviewDate = parsing05
                                }
                                if let parsing06 = i["_id"] as? String{
                                    _id = parsing06
                                }
                                let review0101 = ReviewDetails(reviewerId: reviewerId, reviewBy: reviewBy, review: review, reviewerImage: reviewerImage, reviewDate: reviewDate, _id: _id)
                                self.allReviewdata.append(review0101)
                            }
                        }
                        completion(true)
                    }
                }
            }
        }
    }
    
    func textReviewSubmitApiCall(tokenToSend: String, restaturantId: String, reviewToSend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addReview") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")

        let parameter: [String:Any] = [
            "_id": restaturantId,
            "review": reviewToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_Shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
    
    func photoReviewSubmitApiCall(tokenToSend: String, placeIdToSend: String, images: [UIImage], completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addReviewImage") else{return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
            let data = NSMutableData()
        
        let fieldName = "image"
        for i in images{
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
            data.append(placeIdToSend.data(using: .utf8) ?? data as Data)
            data.append("\r\n".data(using: .utf8) ?? data as Data)
            data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
            request.httpBody = data as Data
        apiResponce_Shared.postFormdatApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
}
