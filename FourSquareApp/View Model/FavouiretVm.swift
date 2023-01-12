//
//  FavouiretVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class FavouiretViewModel {
    static var objectOfViewModel = FavouiretViewModel()
    var objectOfFavouiretNetwork = FavouiretNetwork()
    
    var favSearchDetails = [HomeDataModel]()
    
    func userFavouriteplacesListAndSearch(tokenToSend: String, endpointIs : String, paramsDictionary: [String: Any],completion: @escaping((Bool) -> ())) {
        objectOfFavouiretNetwork.favouiretSearchListFilter(token: tokenToSend, endPoint: endpointIs, paramDictionary: paramsDictionary){ favSearcData, favSearchStatus, favSearchError in
            DispatchQueue.main.async {
                self.favSearchDetails.removeAll()
                if favSearchError == nil{
                    if favSearchStatus == true{
                        if let data0 = favSearcData{
                            if data0.isEmpty{
                                completion(false)
                            }else{
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
                                
                                for i in data0{
                                    if let data01 = i["placeId"] as? String{
                                        placeId = data01
                                    }
                                    if let data02 = i["placeName"] as? String{
                                        placeName = data02
                                    }
                                    if let data03 = i["placeImage"] as? String{
                                        imageUrl = data03
                                    }
                                    if let data04 = i["placeAddress"] as? String{
                                        address = data04
                                    }
                                    if let data05 = i["placeCity"] as? String{
                                        cityName = data05
                                    }
                                    if let data06 = i["placeCategory"] as? String{
                                        print("cat : \(data06)")
                                        category = data06
                                    }
                                    if let data07 = i["placePriceRange"] as? Int{
                                        priceRangeIs = String(data07)
                                    }
                                    if let data08 = i["rating"] as? Double{
                                        let number = Float(data08)
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
                                    
                                    let favSearch = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs,latitude: lati , longitude:longi)
    //                                print("search data : \(imageUrl)\n\(placeId)\n\(placeName)\n\(ratingIs)\n\(priceRangeIs)\n\(category)\n\(distanceIs)\n\(address)\n\(cityName)")
                                    self.favSearchDetails.append(favSearch)
                                }
                                completion(true)
                                
                                
                                
                            }
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
