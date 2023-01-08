//
//  PlaceDetailsModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
class PlaceDetailsModel {
    var latitude: Double
    var longitude: Double
    var placeId: String
    var placeName: String
    var placeImage: String
    var address: String
    var city: String
    var category: String
    var overview: String
    var rating: Double
    var priceRange: Int
    var phoneNumber: String
    
    init(latitude: Double,longitude: Double,placeId: String,placeName: String,placeImage: String,address: String,city: String,category: String,overview: String,rating: Double,priceRange: Int,phoneNumber: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.placeId = placeId
        self.placeName = placeName
        self.placeImage = placeImage
        self.address = address
        self.city = city
        self.category = category
        self.overview = overview
        self.rating = rating
        self.priceRange = priceRange
        self.phoneNumber = phoneNumber
    }
    
}
