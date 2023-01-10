//
//  File.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 05/01/23.
//

import Foundation
class SearchViewModel {
    
    static var objectOfViewModel = SearchViewModel()
    var objectOfSearchNetworkManager = SearchNetworkManager()
    
    var filterSearchDetails = [HomeDataModel]()
    var searchDetaisl = [HomeDataModel]()
    var nearCityData = [NearCityModel]()
    
    func getNearCityDetailsApiCall(latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        
        objectOfSearchNetworkManager.callNearCityApi(lat: latToSend, long: longToSend){ nearData, nearStatus, nearError in
            
            DispatchQueue.main.async {
                self.nearCityData.removeAll()
                if nearError == nil{
                    
                    if nearStatus == true{
                        
                        var cityId = ""
                        var cityName = ""
                        var cityImage = ""
                        
                        
                        if let data0 = nearData{
                            
                            for i in data0{
                                if let data1 = i["_id"] as? String{
                                    
                                    cityId = data1
                                    
                                }
                                if let data2 = i["city"] as? String{
                                    
                                    cityName = data2
                                }
                                if let data3 = i["image"] as? String{
                                    cityImage = data3
                                }
                                
                                let near = NearCityModel(cityId: cityId, cityName: cityName, cityImage: cityImage)
                                
                                self.nearCityData.append(near)
                            }
                            
                            
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
    
    
    func search(tokenToSend: String,latToSend: String, longToSend: String
                ,textIs: String, completion: @escaping((Bool) -> ())) {
        objectOfSearchNetworkManager.searchApicalling(Token: tokenToSend, lat: latToSend, long: longToSend, tesxtToSend: textIs){searchData, searchStatus, SearchError in
            
            
            DispatchQueue.main.async {
                self.searchDetaisl.removeAll()
                if SearchError == nil{
                    if searchStatus == true{
                        
                        if let data0 = searchData{
                            if data0.isEmpty{
                                completion(false)
                            }else{
                                
                                print("collection cell data : \(data0)")
                                
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
                                    
                                    let search = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs, latitude: lati , longitude:longi)
                                    self.searchDetaisl.append(search)
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
    
    func searchWithFilterApiCall(tokenToSend: String, parameterDictionary: [String:Any], completion: @escaping((Bool) -> ())) {
        
        objectOfSearchNetworkManager.searchWithFilter(Token: tokenToSend, paramDictionary: parameterDictionary){ filterData, filterStatus, filterError in
            DispatchQueue.main.async {
                self.filterSearchDetails.removeAll()
                if filterError == nil{
                    if filterStatus == true{
                        
                        if let data0 = filterData{
                            if(data0.isEmpty) {
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
                                    let filterSearch = HomeDataModel(_id: placeId, placeName: placeName, placeImage: imageUrl, address: address, city: cityName, category: category, priceRange: priceRangeIs, rating: ratingIs, distance: distanceIs, latitude: lati , longitude:longi)
    //                                print("search data : \(imageUrl)\n\(placeId)\n\(placeName)\n\(ratingIs)\n\(priceRangeIs)\n\(category)\n\(distanceIs)\n\(address)\n\(cityName)")
                                    self.filterSearchDetails.append(filterSearch)
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
