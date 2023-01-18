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
    
    var commonVm = CommonVm()
    var filterSearchDetails = [HomeData]()
    var searchDetaisl = [HomeData]()
    var nearCityData = [NearCity]()
    
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
                                
                                let near = NearCity(cityId: cityId, cityName: cityName, cityImage: cityImage)
                                
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
                                
                                self.searchDetaisl = self.commonVm.commonParsing(parsingdata: data0)
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
                               
                                self.filterSearchDetails = self.commonVm.commonParsing(parsingdata: data0)
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
