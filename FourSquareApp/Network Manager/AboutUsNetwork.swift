//
//  AboutUsNetwork.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class AboutUsNetwork {
    var ApiResponceObject = ApiResponce()
    
    func aboutUsApi(completion: @escaping(([[String: Any]]?,Bool,Error?) -> ())) {
        
        guard let url = URL(string:"https://four-square-three.vercel.app/api/getAboutUs") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        ApiResponceObject.apiResonce(requestType: request){ reponceData, responceStatus, responceError in
            if responceError == nil{
                if responceStatus == true{
                    print(566,reponceData)
                    if let aboutdata = reponceData as? [[String: Any]]{
                        print(55,aboutdata)
                        completion(aboutdata,true,nil )
                    }
                }else{
                    completion(nil,false,responceError)
                }
            }else{
                completion(nil,false,responceError)
            }
        }
    }
    
}
