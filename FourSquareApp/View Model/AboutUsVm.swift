//
//  AboutUsVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
class AboutUsViewModel {
    
    static var objectOfViewModel = AboutUsViewModel()
    var objectOfAboutUsNetwork = AboutUsNetwork()
    
    var aboutDataIsIS = ""
    func ApiCallForAboutUs(completion: @escaping((Bool) -> ())) {
        objectOfAboutUsNetwork.aboutUsApi(){ aboutData, aboutStatus, aboutError in
            DispatchQueue.main.async {
                if aboutError == nil{
                    if aboutStatus == true{
                        if let data0 = aboutData {
                            
                            for i in data0{
                                if let dataIS = i["aboutUs"] as? String{
                                    
                                    self.aboutDataIsIS = dataIS
                                }
                            }
                        }
                        completion(true)
                    }else{
                        completion(false)
                    }
                }else{
                    completion(false)
                }
            }
        }
    }
}
