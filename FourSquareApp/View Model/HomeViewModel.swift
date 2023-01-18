//
//  File.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
import UIKit

class HomeViewModel {
    
    
    var userFavouiretListArray = [String]()
    
    var commonVm = CommonVm()
    static var objectOfViewModel = HomeViewModel()
    var objectOfHomeNetwork = HomeNetwork()
    
    var homeDetails = [HomeData]()
    var userDetails = [UserDetails]()
    var userLocation = [UserLocation]()
    var favouiretIdData = [FavoriteDetails]()
    
    func apiCallForData(endPoint: String,latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.callHomeApi(endPoint: endPoint, lat: latToSend, long: longToSend){ dataIs, statusIs, errorIs in
            
            DispatchQueue.main.async {
                self.homeDetails.removeAll()
                if errorIs == nil{
                    if statusIs == true{
                        if let data1 = dataIs{
                            self.homeDetails = self.commonVm.commonParsing(parsingdata: data1)
                        }
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
    
    
    func updateUserLocation(lat: String, long: String) {
        userLocation.removeAll()
        let location = UserLocation(latitude: lat, longitude: long)
        userLocation.append(location)
    }
    
    
    func signOutApiCall(tokenToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.signOutApi(token: tokenToSend){ logOutStatus, logOutError in
            DispatchQueue.main.async {
                if logOutError == nil{
                    if logOutStatus == true{
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
    
    
    func userDetailsApiCall(tokenToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.userDetails(token: tokenToSend){ userData, userStatus, userError in
            DispatchQueue.main.async {
                if userError == nil{
                    if userStatus == true{
                        var userName = ""
                        var userProfile = ""
                        var userId = ""
                        if let data0 = userData{
                            if let data01 = data0["userName"] as? String{
                                userName = data01
                            }
                            if let data02 = data0["userImage"] as? String{
                                userProfile = data02
                            }
                            if let data03 = data0["_id"] as? String{
                                userId = data03
                            }
                            let user = UserDetails(userName: userName, userProfileImage: userProfile, userId: userId)
                            self.userDetails.append(user)
                        }
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
    
    func feedBackApiCall(tokenToSend: String, feedbackIs: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.feedbackApi(token: tokenToSend, feddBack: feedbackIs){ feedbackStatus, feedbackError in
            DispatchQueue.main.async {
                if feedbackError == nil{
                    if feedbackStatus == true{
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
    
    func AllFavouiretPlaceIdApiCall(tokenIs: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.favouiretPlaceIdies(token: tokenIs){ idData,idStatus, idError in
            DispatchQueue.main.async {
                self.favouiretIdData.removeAll()
                self.userFavouiretListArray.removeAll()
                if idError == nil{
                    if idStatus == true{
                        if let data0 = idData{
                            var placeIdIs = ""
                            var _IdIs = ""
                            if let data01 = data0["favouritePlaces"] as? [[String: Any]]{
                                for i in data01{
                                    if let data001 = i["placeId"] as? String{
                                        
                                        self.userFavouiretListArray.append(data001)
                                        
                                        placeIdIs = data001
                                    }
                                    if let data002 = i["_id"] as? String{
                                        _IdIs = data002
                                    }
                                    let favId = FavoriteDetails(placeIs: placeIdIs, _Id: _IdIs)
                                    self.favouiretIdData.append(favId)
                                }
                            }
                        }
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
    
    func userProfilePhotoUpdateApiCall(token: String, imageIs: UIImage, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.updateUserProfile(token: token, image: imageIs){ userStatus, userError in
            DispatchQueue.main.async {
                if userError == nil{
                    if userStatus == true{
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
