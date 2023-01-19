//
//  File.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 05/01/23.
//

import Foundation
class SearchViewModel {
    
    var apiResponce = ApiResponce()
    static var objectOfViewModel = SearchViewModel()
    var objectOfSearchNetworkManager = SearchNetworkManager()
    
    var commonVm = CommonVm()
    var filterSearchDetails = [HomeData]()
    var searchDetaisl = [HomeData]()
    var nearCityData = [NearCity]()
    
    func getNearCityDetailsApiCall(latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getNearCity") else{ return }
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
                if error != nil && status != true{
                    completion(false)
                    return
                }
                
                if let parsing0 = data as? [[String: Any]]{
                    var cityId = ""
                    var cityName = ""
                    var cityImage = ""
                    for i in parsing0{
                        if let parsing1 = i["_id"] as? String{
                            cityId = parsing1
                        }
                        if let parsing2 = i["city"] as? String{
                            
                            cityName = parsing2
                        }
                        if let parsing3 = i["image"] as? String{
                            cityImage = parsing3
                        }
                        let near = NearCity(cityId: cityId, cityName: cityName, cityImage: cityImage)
                        self.nearCityData.append(near)
                    }
                    completion(true)
                }
            }
        }
    }
    
    func search(tokenToSend: String,latToSend: String, longToSend: String
                ,textToSend: String, completion: @escaping((Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/filterSearch") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "latitude": latToSend,
            "longitude": longToSend,
            "text": textToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                    return
                }
                
                if let parsing0 = data as? [[String: Any]]{
                    if parsing0.isEmpty{
                        completion(false)
                    }else{
                        self.searchDetaisl.removeAll()
                        self.searchDetaisl = self.commonParsing(parsingdata: parsing0)
                        completion(true)
                    }
                }
            }
        }
    }
    
    func searchWithFilterApiCall(tokenToSend: String, parameterDictionary: [String:Any], completion: @escaping((Bool) -> ())) {
        
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/filterSearch") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = parameterDictionary
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                    return
                }
                
                if let parsing0 = data as? [[String: Any]]{
                    if(parsing0.isEmpty) {
                        completion(false)
                    }else{
                        self.filterSearchDetails.removeAll()
                        self.filterSearchDetails = self.commonParsing(parsingdata: parsing0)
                        completion(true)
                    }
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
