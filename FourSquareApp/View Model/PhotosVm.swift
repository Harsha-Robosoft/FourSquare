//
//  PhotosVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class PhotoViewModel {
    var apiResponce_shared = ApiResponce()
    static var _shared = PhotoViewModel()
    
    var AllPhotosDetails = [PhotosDetails]()
    
    func getAllPhotosApicall(tokenToSend: String, placeIdToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getReviewImage") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        
        let parameter: [String:Any] = [
            "_id": placeIdToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                
                if error != nil && status != true{
                    completion(false)
                }
                
                if let parsing0 = data as? [String: Any]{
                    if parsing0.isEmpty{
                        completion(false)
                    }else{
                        if let parsing1 = parsing0["reviewImage"] as? [[String: Any]]{
                            var reviewerId = ""
                            var reviewBy = ""
                            var reviewerImage = ""
                            var reviewDate = ""
                            var _id = ""
                            var image = ""
                            
                            for i in parsing1{
                                
                                if let parsing01 = i["reviewerId"] as? String{
                                    reviewerId = parsing01
                                }
                                if let parsing02 = i["reviewBy"] as? String{
                                    reviewBy = parsing02
                                }
                                if let parsing03 = i["reviewerImage"] as? String{
                                    reviewerImage = parsing03
                                }
                                if let parsing04 = i["reviewDate"] as? String{
                                    reviewDate = parsing04
                                }
                                if let parsing05 = i["_id"] as? String{
                                    _id = parsing05
                                }
                                if let parsing06 = i["image"] as? [String]{
                                    for i in parsing06{
                                        image = i
                                    }
                                }
                                let photosIs = PhotosDetails(reviewerId: reviewerId, reviewBy: reviewBy, reviewerImage: reviewerImage, reviewDate: reviewDate, _id: _id, imageIs: image)
                                self.AllPhotosDetails.append(photosIs)
                            }
                            completion(true)
                        }
                    }
                }
            }
        }
    }
}
