//
//  OtpVarificationVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation

class OtpvarificationViewModel {
    
    var apiResponce = ApiResponce()
    static var objectOfVc = OtpvarificationViewModel()
    var objectOfOtpVarificationNetwork = OtpVarificationNetwork()
    
    func sendOtpApiCall(emailToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/sendOtp") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": emailToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                }else{
                    completion(true)
                }
                
            }
        }
    }
    
    
    func varifyOtpApicall(otpToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/verifyOtp") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "otp": otpToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true {
                    completion(false)
                }else{
                    completion(true)
                }
                
            }
        }
    }
    
    
    func chekMailIdIsValidApiCall(emailToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/emailExists") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter: [String:Any] = [
            "email": emailToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce.postApiResonce(request: request){ data, status, error in
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
