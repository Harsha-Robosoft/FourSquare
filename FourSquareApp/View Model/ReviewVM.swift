//
//  ReviewVM.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
import UIKit
class ReviewViewModel {
    
    static var objectOfViewModel = ReviewViewModel()
    var objectOfReviewNetworkManager = ReviewNetworkManager()
    
    var allReviewdata = [AllReviewModel]()
    
    func getAllReviewDataApiCall(tokenIs: String, placeIdis: String, completion: @escaping((Bool) -> ())) {
        objectOfReviewNetworkManager.Allreviews(token: tokenIs, placeId: placeIdis){reviewData, reviewStatus, reviewError in
            DispatchQueue.main.async {
                if reviewError == nil{
                    if reviewStatus == true{
                        
                        if let data0 = reviewData{
                            
                            if data0.isEmpty{
                                completion(false)
                            }else{
                                if let data1 = data0["reviewText"] as? [[String: Any]]{
                                    
                                    var reviewerIdIs = ""
                                    var reviewByIs = ""
                                    var reviewIs = ""
                                    var reviewerImageIs = ""
                                    var reviewDateIs = ""
                                    var _idIs = ""
                                    
                                    for i in data1{
                                        
                                        if let data01 = i["reviewerId"] as? String{
                                            reviewerIdIs = data01
                                        }
                                        if let data02 = i["reviewBy"] as? String{
                                            reviewByIs = data02
                                        }
                                        if let data03 = i["review"] as? String{
                                            reviewIs = data03
                                        }
                                        if let data04 = i["reviewerImage"] as? String{
                                            reviewerImageIs = data04
                                        }
                                        if let data05 = i["reviewDate"] as? String{
                                            reviewDateIs = data05
                                        }
                                        if let data06 = i["_id"] as? String{
                                            _idIs = data06
                                        }
                                        
                                        let review0101 = AllReviewModel(reviewerId: reviewerIdIs, reviewBy: reviewByIs, review: reviewIs, reviewerImage: reviewerImageIs, reviewDate: reviewDateIs, _id: _idIs)
                                        
                                        self.allReviewdata.append(review0101)
                                    }
                                }
                                completion(true)
                            }

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
    
    func textReviewSubmitApiCall(tokenIs: String, restaturantId: String, reviewIs: String, completion: @escaping((Bool) -> ())) {
        objectOfReviewNetworkManager.textReviewSubmit(token: tokenIs, restaturantId: restaturantId, reviewIs: reviewIs){ textStatus, textError in
            DispatchQueue.main.async {
                if textError == nil{
                    if textStatus == true{
                        completion(true)
                    }else{
                        completion(false)
                    }
                }else{
                    completion(false)
                }
            }
        }
    }
    
    func photoReviewSubmitApiCall(rokenIs: String, placeIdIs: String, images: [UIImage], completion: @escaping((Bool) -> ())) {
        objectOfReviewNetworkManager.photoReviewSubmit(token: rokenIs, placeId: placeIdIs, image: images){ photoStatus, photoError in
            DispatchQueue.main.async {
                if photoError == nil{
                    if photoStatus == true{
                        completion(true)
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
