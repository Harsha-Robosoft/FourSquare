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
    
    var nearCityData = [NearCityModel]()
    
    func getNearCityDetailsApiCall(latToSend: String, longToSend: String, completion: @escaping((Bool) -> ())) {
        
        objectOfSearchNetworkManager.callNearCityApi(lat: latToSend, long: longToSend){ nearData, nearStatus, nearError in
            self.nearCityData.removeAll()
            DispatchQueue.main.async {
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
    
    
    func search(latToSend: String, longToSend: String
                ,textIs: String, completion: @escaping((Bool) -> ())) {
        objectOfSearchNetworkManager.searchApicalling(lat: latToSend, long: longToSend, tesxtToSend: textIs){searchData, searchStatus, SearchError in
            DispatchQueue.main.async {
                if SearchError == nil{
                    if searchStatus == true{
                        
                        
                        
                        
                        
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
