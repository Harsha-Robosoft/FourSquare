//
//  HomeDataModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
class HomeData {
    
    var latitude:Double
    var longitude: Double
    
    var _id: String
    var placeName: String
    var placeImage: String
    var address: String
    var city: String
    var category: String
    var priceRange: String
    var rating: String
    var distance: String
    
    init(_id: String,placeName: String,placeImage: String,address: String,city: String,category: String,priceRange: String,rating: String,distance: String,latitude:Double,longitude: Double) {
        self._id = _id
        self.placeName = placeName
        self.placeImage = placeImage
        self.address = address
        self.city = city
        self.category = category
        self.priceRange = priceRange
        self.rating = rating
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
    }
}
