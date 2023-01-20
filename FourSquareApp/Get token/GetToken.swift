//
//  GetToken.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 19/01/23.
//

import Foundation
import UIKit

class GetToken {
    
    static var _shared = GetToken()
    var userDefaults_Shared = UserDefaults()
    var keyChain_Shared = KeyChain()
    
    func getToken() -> String {
        var id = ""
       let userIdIs = userDefaults_Shared.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        guard let receivedTokenData = keyChain_Shared.loadData(userId: id) else {print("Token 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("Token 3")
            return ""}
        return receivedToken
    }
}
