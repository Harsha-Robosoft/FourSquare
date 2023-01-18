//
//  CommonVmForHome,SearchAndPlaceDEtailsVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 18/01/23.
//

import Foundation
class CommonVm {
    func commonParsing(parsingdata: [[String: Any]]) -> [HomeData] {
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
        
        var arr = [HomeData]()
        for i in parsingdata{
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
                    let number = Float(Float(data10) / 1609)
                    distanceIs = String(format: "%.1f", number)
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
            
            let details = HomeData(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs, latitude: lati , longitude:longi)
            arr.append(details)
        }
        return arr
    }
}
