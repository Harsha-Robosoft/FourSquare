//
//  GetToken.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 19/01/23.
//

import Foundation
import UIKit

class GetToken {
    
    static var getTheUserToken = GetToken()
    
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    
    
    func getToken() -> String {
        var id = ""
       let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Home id : \(id)")
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Home token",receivedToken)
        return receivedToken
    }
}
