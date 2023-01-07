//
//  UserDetailsModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class UserDetailsModel {
    var userName: String
    var userProfileImage: String
    var userId: String
    
    init(userName: String,userProfileImage: String,userId: String) {
        self.userName = userName
        self.userProfileImage = userProfileImage
        self.userId = userId
    }
}
