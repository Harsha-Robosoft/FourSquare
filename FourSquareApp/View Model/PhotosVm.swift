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
    
    func getAllPhotosApicall(tokenIs: String, placeIdis: String, completion: @escaping((Bool) -> ())) {
        objectOfPhotoNetworkModel.getAllPhotos(token: tokenIs, placeId: placeIdis){ photodata, photoStatus, photoError in
            DispatchQueue.main.async {
                if photoError == nil{
                    if photoStatus == true{
                        
                        if let data0 = photodata{
                           
                            if let data1 = data0["reviewImage"] as? [[String: Any]]{
                                
                                
                                
                                
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
