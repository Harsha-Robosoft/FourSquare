//
//  ReviewVM.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class ReviewViewModel {
    
    static var objectOfViewModel = ReviewViewModel()
    var objectOfReviewNetworkManager = ReviewNetworkManager()
    
    func getAllReviewDataApiCall(tokenIs: String, placeIdis: String, completion: @escaping((Bool) -> ())) {
        objectOfReviewNetworkManager.Allreviews(token: tokenIs, placeId: placeIdis){reviewData, reviewStatus, reviewError in
            DispatchQueue.main.async {
                if reviewError == nil{
                    if reviewStatus == true{
                        
                        if let data0 = reviewData{
                            
                            if let data1 = data0["reviewText"] as? [[String: Any]]{
                                
                                
                            }
                            
                            completion(true)
                        }
                        
                        
                    }else{
                        completion(false)
                    }
                }else{
                    completion(false)
                }
            }
        }
    }
}
