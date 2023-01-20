//
//  PlaceDetailsVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class PlaceDetailsViewModel {
    
    var apiResponce_shared = ApiResponce()
    static var _shared = PlaceDetailsViewModel()
    
    var perticularPlaceDetails = [PlaceDetails]()
    
    func perticularPlaceDetailsApiCall(placeId: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getParticularPlace") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "_id": placeId
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                    return
                }
                if let parsing0 = data as? [String: Any]{
                    if(parsing0.isEmpty) {
                        completion(false)
                    }else{
                        var lat = 0.0
                        var long = 0.0
                        var placeId = ""
                        var placeName = ""
                        var imageUrl = ""
                        var address = ""
                        var cityName = ""
                        var category = ""
                        var overview = ""
                        var rating = 0.0
                        var priceRange = 0
                        var phoneNum = ""
                        if let parsing1 = parsing0["_id"] as? String{
                            placeId = parsing1
                        }
                        if let parsing2 = parsing0["placeName"] as? String{
                            placeName = parsing2
                        }
                        if let parsing3 = parsing0["placeImage"] as? String{
                            imageUrl = parsing3
                        }
                        if let parsing4 = parsing0["address"] as? String{
                            address = parsing4
                        }
                        if let parsing5 = parsing0["city"] as? String{
                            cityName = parsing5
                        }
                        if let parsing6 = parsing0["category"] as? String{
                            category = parsing6
                        }
                        if let parsing7 = parsing0["overview"] as? String{
                            overview = parsing7
                        }
                        if let parsing8 = parsing0["priceRange"] as? Int{
                            priceRange = parsing8
                        }
                        if let parsing9 = parsing0["rating"] as? Double{
                            rating = parsing9
                        }
                        if let parsing10 = parsing0["placePhone"] as? String{
                            phoneNum = parsing10
                        }
                        if let parsing11 = parsing0["location"] as? [String:Any]{
                            if let parsing001 = parsing11["coordinates"] as? [Double]{
                                lat = parsing001[1]
                                long = parsing001[0]
                            }
                        }
                        let place = PlaceDetails(latitude: lat, longitude: long, placeId: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, overview: overview, rating: rating, priceRange: priceRange, phoneNumber: phoneNum)
                        self.perticularPlaceDetails.append(place)
                        completion(true)
                    }
                }
            }
        }
    }
    
    
    func addRatingApiCall(tokenTosend: String, placeId: String, ratingToSend: Int, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addRating") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenTosend)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "_id": placeId,
            "rating": ratingToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
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
