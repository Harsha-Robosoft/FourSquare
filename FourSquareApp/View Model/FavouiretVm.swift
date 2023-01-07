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
    
    func userFavouriteplacesListAndSearch(tokenToSend: String, paramsDictionary: [String: Any],completion: @escaping((Bool) -> ())) {
        objectOfFavouiretNetwork.favouiretSearchListFilter(token: tokenToSend, paramDictionary: paramsDictionary){ favSearcData, favSearchStatus, favSearchError in
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
     
                                for i in data0{
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
                                    if let data08 = i["rating"] as? Float{
                                        ratingIs = String(data08)
                                    }
                                    if let data09 = i["distance"] as? [String: Any]{
                                        if let data10 = data09["calculated"] as? Double{
                                            distanceIs = String(Int(Double(data10) / Double(1609)))
                                        }
                                    }
                                    let favSearch = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs)
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
