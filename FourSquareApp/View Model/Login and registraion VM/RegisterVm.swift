//
//  RegisterVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class RegisterViewModel {
    var apiResponce = ApiResponce()
    static var objectOfVm = RegisterViewModel()
    var obejctOfRegisterNetwork = RegisterNetwork()
    
    func apiCallForUserRegistration(emailToSend: String, mobileNumberToSend: String, passwordToSend: String, completion: @escaping((String, Bool) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/register") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": emailToSend,
            "phoneNumber": mobileNumberToSend,
            "password": passwordToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion("Error while registration try again.",false)
                    return
                }
                if let parsing1 = data as? [String: Any] {
                    if let parsing2 = parsing1["message"] as? String{
                        completion(parsing2, true)
                    }
                }
            }
        }
    }
}
