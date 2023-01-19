//
//  Key chain.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import Foundation
class KeyChain {
    func saveData(userId: String, data: Data)  {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
            kSecValueData as String   : data ] as [String : Any]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error: \(status)")
        }
        print("status : \(status)")
        if status == errSecDuplicateItem {
            let query = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrAccount as String : userId,
                kSecValueData as String   : data ] as [String : Any]
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query as CFDictionary, attributesToUpdate)
        }
    }
    
    func loadData(userId: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ] as [String: Any]
        
        var result: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)
        if status == noErr {
            return result as! Data?
        } else {
            return nil
        }
    }
    
    func deletePassword(userId: String) {
        
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ] as [String: Any]
        
        let status = SecItemDelete(query as CFDictionary)
    }
}
