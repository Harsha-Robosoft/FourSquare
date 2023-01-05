//
//  NearCityModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 05/01/23.
//

import Foundation
class NearCityModel {
    var cityId: String
    var cityName: String
    var cityImage: String
    
    init(cityId: String,cityName: String,cityImage: String) {
        self.cityId = cityId
        self.cityName = cityName
        self.cityImage = cityImage
    }
}
