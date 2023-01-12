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
    
    
    static var objectOfViewModel = HomeViewModel()
    var objectOfHomeNetwork = HomeNetwork()
    
    var homeDetails = [HomeDataModel]()
    var userDetails = [UserDetailsModel]()
    var userLocation = [UserLocationModel]()
    var favouiretIdData = [FavouiretIdModel]()
    
    func apiCallForData(endPoint: String,latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.callHomeApi(endPoint: endPoint, lat: latToSend, long: longToSend){ dataIs, statusIs, errorIs in
            
            DispatchQueue.main.async {
                self.homeDetails.removeAll()
                if errorIs == nil{
                    if statusIs == true{
                        if let data1 = dataIs{
                            var imageUrl = ""
                            var placeId = ""
                            var placeName = ""
                            var ratingIs = ""
                            var priceRangeIs = ""
                            var category = ""
                            var distanceIs = ""
                            var address = ""
                            var cityName = ""
                            
                            var lati = 0.0
                            var longi = 0.0
                            
                            for i in data1{
                                if let data01 = i["_id"] as? String{
                                    placeId = data01
                                }
                                if let data02 = i["placeName"] as? String{
                                    placeName = data02
                                }
                                if let data03 = i["placeImage"] as? String{
                                    imageUrl = data03
                                }
                                if let data04 = i["address"] as? String{
                                    address = data04
                                }
                                if let data05 = i["city"] as? String{
                                    cityName = data05
                                }
                                if let data06 = i["category"] as? String{
                                    category = data06
                                }
                                if let data07 = i["priceRange"] as? Int{
                                    priceRangeIs = String(data07)
                                }
                                if let data08 = i["rating"] as? Double{
                                    print("6565",data08)

                                    let number = Double(data08)
                                    ratingIs = String(format: "%.1f", number)
                                }
                                if let data09 = i["distance"] as? [String: Any]{
                                    if let data10 = data09["calculated"] as? Double{
//                                        distanceIs = String(Float(Float(data10) / 1609))
                                        let number = Float(Float(data10) / 1609)
                                        distanceIs = String(format: "%.1f", number)
                                        
//                                        let roundedNumber = String(format: "%.1f", number)

                                    }
                                }
                                
                                if let data10 = i["location"] as? [String: Any]{
                                    if let data11 = data10["coordinates"] as? [Double]{
                                        print("longi : \(data11[0])")
                                        print("lati : \(data11[1])")
                                        lati = data11[1]
                                        longi = data11[0]
                                    }
                                }
                                
                                let details = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs, latitude: lati , longitude:longi)
                                self.homeDetails.append(details)
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
    
    
    func updateUserLocation(lat: String, long: String) {
        userLocation.removeAll()
        let location = UserLocationModel(latitude: lat, longitude: long)
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
                            let user = UserDetailsModel(userName: userName, userProfileImage: userProfile, userId: userId)
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
                                    let favId = FavouiretIdModel(placeIs: placeIdIs, _Id: _IdIs)
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
