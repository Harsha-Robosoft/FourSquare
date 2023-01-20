//
//  ForgotPasswordVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation
class ForgotPasswordViewModel {
    var apiResponce_shared = ApiResponce()
    static var _shared = ForgotPasswordViewModel()
    
    func forgotPassewordApiCall(emailToSend: String, passwordToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/forgotPassword") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": emailToSend,
            "password": passwordToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                }else{
                    completion(true)
                }
                
            }
        }
    }
}
