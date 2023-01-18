//
//  AllReviewModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class ReviewDetails {
    var reviewerId: String
    var reviewBy: String
    var review: String
    var reviewerImage: String
    var reviewDate: String
    var _id: String
    
    init(reviewerId: String,reviewBy: String,review: String,reviewerImage: String,reviewDate: String,_id: String) {
        self.reviewerId = reviewerId
        self.reviewBy = reviewBy
        self.review = review
        self.reviewerImage = reviewerImage
        self.reviewDate = reviewDate
        self._id = _id
    }
}
