//
//  PhotosVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class PhotoViewModel {
    static var objectOfViewModel = PhotoViewModel()
    var objectOfPhotoNetworkModel = PhotoNetworkModel()
    
    var AllPhotosDetails = [PhotosDetails]()
    
    func getAllPhotosApicall(tokenIs: String, placeIdis: String, completion: @escaping((Bool) -> ())) {
        objectOfPhotoNetworkModel.getAllPhotos(token: tokenIs, placeId: placeIdis){ photodata, photoStatus, photoError in
            DispatchQueue.main.async {
                self.AllPhotosDetails.removeAll()
                if photoError == nil{
                    if photoStatus == true{
                        
                        if let data0 = photodata{
                           
                            if data0.isEmpty{
                                completion(false)
                            }else{
                                if let data1 = data0["reviewImage"] as? [[String: Any]]{
                                    var reviewerIdIs = ""
                                    var reviewByIs = ""
                                    var reviewerImageIs = ""
                                    var reviewDateIs = ""
                                    var _idIs = ""
                                    var imageISIS = ""
                                    
                                    for i in data1{
                                        
                                        if let data01 = i["reviewerId"] as? String{
                                            reviewerIdIs = data01
                                        }
                                        if let data02 = i["reviewBy"] as? String{
                                            reviewByIs = data02
                                        }
                                        if let data03 = i["reviewerImage"] as? String{
                                            reviewerImageIs = data03
                                        }
                                        if let data04 = i["reviewDate"] as? String{
                                            reviewDateIs = data04
                                        }
                                        if let data05 = i["_id"] as? String{
                                            _idIs = data05
                                        }
                                        if let data06 = i["image"] as? [String]{
                                            for i in data06{
                                                imageISIS = i
                                            }
                                            
                                            
                                        }
                                        
                                        let photosIs = PhotosDetails(reviewerId: reviewerIdIs, reviewBy: reviewByIs, reviewerImage: reviewerImageIs, reviewDate: reviewDateIs, _id: _idIs, imageIs: imageISIS)
                                        
                                        self.AllPhotosDetails.append(photosIs)
                                    }
                                    completion(true)
                                }
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
}
