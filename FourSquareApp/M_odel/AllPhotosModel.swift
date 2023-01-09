//
//  AllPhotosModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class AllPhotosModel {
    
    var imageIs: String
    
    var reviewerId: String
    var reviewBy: String
    var reviewerImage: String
    var reviewDate: String
    var _id: String
    init(reviewerId: String,reviewBy: String,reviewerImage: String,reviewDate: String,_id: String,imageIs: String) {
        self.reviewerId = reviewerId
        self.reviewBy = reviewBy
        self.reviewerImage = reviewerImage
        self.reviewDate = reviewDate
        self._id = _id
        self.imageIs = imageIs
    }
}
