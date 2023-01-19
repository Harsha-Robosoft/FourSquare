//
//  File.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var apiResponce = ApiResponce()
    var commonVm = CommonVm()
    static var objectOfViewModel = HomeViewModel()
    var objectOfHomeNetwork = HomeNetwork()
    
    
    var userFavouiretListArray = [String]()

    var homeDetails = [HomeData]()
    var userDetails = [UserDetails]()
    var userLocation = [UserLocation]()
    var favouiretIdData = [FavoriteDetails]()
    
    func apiCallForData(endPoint: String,latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api\(endPoint)") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "latitude": latToSend,
            "longitude": longToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                    return
                }
                if let dataToSend = data as? [[String: Any]]{
                    self.homeDetails.removeAll()
                    self.homeDetails = self.commonVm.commonParsing(parsingdata: dataToSend)
                    completion(true)
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
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/logout") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                    return
                }else{
                    completion(true)
                }
            }
        }
    }
    
    
    func userDetailsApiCall(tokenToSend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getProfile") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                    return
                }
                
                if let parsing1 = data as? [String: Any]{
                    var userName = ""
                    var userProfile = ""
                    var userId = ""
                    if let parsing01 = parsing1["userName"] as? String{userName = parsing01}
                    if let parsing02 = parsing1["userImage"] as? String{userProfile = parsing02}
                    if let parsing03 = parsing1["_id"] as? String{userId = parsing03}
                    let user = UserDetails(userName: userName, userProfileImage: userProfile, userId: userId)
                    self.userDetails.append(user)
                    completion(true)
                }
            }
        }
    }
    
    func feedBackApiCall(tokenToSend: String, feedbackToSend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addFeedback") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "feedback": feedbackToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
    
    func AllFavouiretPlaceIdApiCall(tokenTosend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getFavouriteId") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(tokenTosend)", forHTTPHeaderField: "Authorization")
        
        apiResponce.getApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                    return
                }
                
                if let parsing1 = data as? [String: Any]{
                    var placeIdIs = ""
                    var _IdIs = ""
                    if let parsing01 = parsing1["favouritePlaces"] as? [[String: Any]]{
                        for i in parsing01{
                            if let parsing001 = i["placeId"] as? String{
                                self.userFavouiretListArray.append(parsing001)
                                placeIdIs = parsing001
                            }
                            if let parsing002 = i["_id"] as? String{_IdIs = parsing002}
                            let favId = FavoriteDetails(placeIs: placeIdIs, _Id: _IdIs)
                            self.favouiretIdData.append(favId)
                        }
                    }
                    completion(true)
                }
            }
        }
    }
    
    func userProfilePhotoUpdateApiCall(token: String, imageTosend: UIImage, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addProfileImage") else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let data = NSMutableData()
        
        let fieldName = "image"
        if let imageData = imageTosend.jpegData(compressionQuality: 0.1) {
            data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
            data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8) ?? data as Data)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) ?? data as Data)
            data.append(imageData)
            data.append("\r\n".data(using: .utf8) ?? data as Data)
        }
        data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
        request.httpBody = data as Data
        
        apiResponce.postFormdatApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
}
