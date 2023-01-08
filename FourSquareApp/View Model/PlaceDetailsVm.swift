//
//  PlaceDetailsVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class PlaceDetailsViewModel {
    
    static var objectOfviewModel = PlaceDetailsViewModel()
    var objectOfPlaceDetailsNetworkManager = PlaceDetailsNetworkManager()
    
    var perticularPlaceDetails = [PlaceDetailsModel]()
    
    func perticularPlaceDetailsApiCall(placeId: String, completion: @escaping((Bool) -> ())) {
        objectOfPlaceDetailsNetworkManager.particularPlaceDetails(placeIs: placeId){ placeData, placeStatus, placeError in
            DispatchQueue.main.async {
                self.perticularPlaceDetails.removeAll()
                if placeError == nil{
                    if placeStatus == true{
                        
                        if let data0 = placeData{
                            if(data0.isEmpty) {
                                completion(false)
                            }else{
                               
                                var latIs = 0.0
                                var longIs = 0.0
                                var placeIdIsIS = ""
                                var placeName = ""
                                var imageUrl = ""
                                var address = ""
                                var cityName = ""
                                var category = ""
                                var overview = ""
                                var rating = 0.0
                                var priceRangeIs = 0
                                var phoneNum = ""
                                
                                if let data1 = data0["_id"] as? String{
                                    placeIdIsIS = data1
                                }
                                if let data2 = data0["placeName"] as? String{
                                    placeName = data2
                                }
                                if let data3 = data0["placeImage"] as? String{
                                    imageUrl = data3
                                }
                                if let data4 = data0["address"] as? String{
                                    address = data4
                                }
                                if let data5 = data0["city"] as? String{
                                    cityName = data5
                                }
                                if let data6 = data0["category"] as? String{
                                    category = data6
                                }
                                if let data7 = data0["overview"] as? String{
                                    overview = data7
                                }
                                if let data8 = data0["priceRange"] as? Int{
                                    priceRangeIs = data8
                                }
                                if let data9 = data0["rating"] as? Double{
                                    rating = data9
                                }
                                if let data10 = data0["placePhone"] as? String{
                                    phoneNum = data10
                                }
                                if let data11 = data0["location"] as? [String:Any]{
                                    
                                    if let data001 = data11["coordinates"] as? [Double]{
                                        
                                        latIs = data001[1]
                                        longIs = data001[0]
                                            print("longitude is is is : \(data001[0])")
                                            print("latitude is is is : \(data001[1])")
                                    }
                                
                                }
                                
                                
                                
                                
                                let place = PlaceDetailsModel(latitude: latIs, longitude: longIs, placeId: placeIdIsIS, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, overview: overview, rating: rating, priceRange: priceRangeIs, phoneNumber: phoneNum)
                                self.perticularPlaceDetails.append(place)
                                
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
