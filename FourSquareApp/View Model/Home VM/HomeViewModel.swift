//
//  File.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation

class HomeViewModel {
    
    static var objectOfViewModel = HomeViewModel()
    var objectOfHomeNetwork = HomeNetwork()
    
    var homeDetails = [HomeDataModel]()
    
    func apiCallForData(endPoint: String,latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        objectOfHomeNetwork.callHomeApi(endPoint: endPoint, lat: latToSend, long: longToSend){ dataIs, statusIs, errorIs in
            self.homeDetails.removeAll()
            DispatchQueue.main.async {
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
                                if let data08 = i["rating"] as? Float{
                                    ratingIs = String(data08)
                                }
                                
                                if let data09 = i["distance"] as? [String: Any]{
                                    
                                    if let data10 = data09["calculated"] as? Double{
                                        
                                        distanceIs = String(Int(Double(data10) / Double(1609)))
                                    }
                                    
                                    
                                }
                                
                                let details = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs)
                                self.homeDetails.append(details)

                            }
                            
                            
                            let details = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs)
                            self.homeDetails.append(details)
                            print("data is : \(imageUrl)\n\(placeId)\n\(placeName)\n\(ratingIs)\n\(priceRangeIs)\n\(category)\n\(distanceIs)\n\(address)\n\(cityName)")
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
    
}
