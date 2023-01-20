//
//  AboutUsVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class AboutUsViewModel {
    
    var apiResponce_shared = ApiResponce()
    static var _shared = AboutUsViewModel()
    
    var aboutDataIsIS = ""
    func ApiCallForAboutUs(completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getAboutUs") else{ return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        apiResponce_shared.getApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                    return
                }
                if let parsing0 = data as? [[String: Any]]{
                    for i in parsing0{
                        if let parsing = i["aboutUs"] as? String{
                            self.aboutDataIsIS = parsing
                        }
                    }
                    completion(true)
                }
            }
        }
    }
}
