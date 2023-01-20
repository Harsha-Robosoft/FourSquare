//
//  FavouiretVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class FavoriteViewModel {
    
    var apiResponce_shared = ApiResponce()
    static var _shared = FavoriteViewModel()
    
    var favSearchDetails = [HomeData]()
    
    func userFavouriteplacesListAndSearch(tokenToSend: String, endpointToSend
                                            : String, paramsDictionary: [String: Any],completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api\(endpointToSend)") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenToSend)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = paramsDictionary
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                self.favSearchDetails.removeAll()
                if error != nil && status != true{
                    completion(false)
                    return
                }
                if let parsing0 = data as? [[String: Any]]{
                    if parsing0.isEmpty{
                        completion(false)
                    }else{
                        var imageUrl = ""
                        var placeId = ""
                        var placeName = ""
                        var rating = ""
                        var priceRange = ""
                        var category = ""
                        var distance = ""
                        var address = ""
                        var cityName = ""
                        var lati = 0.0
                        var longi = 0.0
                        
                        for i in parsing0{
                            if let parsing01 = i["placeId"] as? String{
                                placeId = parsing01
                            }
                            if let parsing02 = i["placeName"] as? String{
                                placeName = parsing02
                            }
                            if let parsing03 = i["placeImage"] as? String{
                                imageUrl = parsing03
                            }
                            if let parsing04 = i["placeAddress"] as? String{
                                address = parsing04
                            }
                            if let parsing05 = i["placeCity"] as? String{
                                cityName = parsing05
                            }
                            if let parsing06 = i["placeCategory"] as? String{
                                print("cat : \(parsing06)")
                                category = parsing06
                            }
                            if let parsing07 = i["placePriceRange"] as? Int{
                                priceRange = String(parsing07)
                            }
                            if let parsing08 = i["rating"] as? Double{
                                let number = Float(parsing08)
                                rating = String(format: "%.1f", number)
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
                            let favSearch = HomeData(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRange, rating: rating, distance: distance,latitude: lati , longitude:longi)
                            self.favSearchDetails.append(favSearch)
                        }
                        completion(true)
                    }
                }
            }
        }
    }
}
