//
//  CommonVmForHome,SearchAndPlaceDEtailsVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 18/01/23.
//

import Foundation
class CommonVm {
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
