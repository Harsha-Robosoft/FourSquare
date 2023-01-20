//
//  File.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var apiResponce_shared = ApiResponce()
    static var _shared = HomeViewModel()
    
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
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                    return
                }
                if let dataToSend = data as? [[String: Any]]{
                    self.homeDetails.removeAll()
                    self.homeDetails = self.commonParsing(parsingdata: dataToSend)
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
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
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
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
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
        
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
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
        
        apiResponce_shared.getApiResonce(request: request){ data, status, error in
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
        
        apiResponce_shared.postFormdatApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
    
    func commonParsing(parsingdata: [[String: Any]]) -> [HomeData] {
        var arrayToSend = [HomeData]()
        var imageUrl = ""
        var placeId = ""
        var placeName = ""
        var ratingIs = ""
        var priceRange = ""
        var category = ""
        var distance = ""
        var address = ""
        var cityName = ""
        var lati = 0.0
        var longi = 0.0
        
        arrayToSend.removeAll()
        for i in parsingdata{
            if let parsing01 = i["_id"] as? String{
                placeId = parsing01
            }
            if let parsing02 = i["placeName"] as? String{
                placeName = parsing02
            }
            if let parsing03 = i["placeImage"] as? String{
                imageUrl = parsing03
            }
            if let parsing04 = i["address"] as? String{
                address = parsing04
            }
            if let parsing05 = i["city"] as? String{
                cityName = parsing05
            }
            if let parsing06 = i["category"] as? String{
                category = parsing06
            }
            if let parsing07 = i["priceRange"] as? Int{
                priceRange = String(parsing07)
            }
            if let parsing08 = i["rating"] as? Double{
                let number = Double(parsing08)
                ratingIs = String(format: "%.1f", number)
            }
            if let parsing09 = i["distance"] as? [String: Any]{
                if let parsing10 = parsing09["calculated"] as? Double{
                    let number = Float(Float(parsing10) / 1609)
                    distance = String(format: "%.1f", number)
                }
            }
            
            if let parsing10 = i["location"] as? [String: Any]{
                if let parsing11 = parsing10["coordinates"] as? [Double]{
                    lati = parsing11[1]
                    longi = parsing11[0]
                }
            }
            
            let details = HomeData(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRange, rating: ratingIs, distance: distance, latitude: lati , longitude:longi)
            arrayToSend.append(details)
        }
        return arrayToSend
    }
}
