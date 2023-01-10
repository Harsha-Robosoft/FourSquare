//
//  AddToFavouiretVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class AddToFavouiretViewModel {
    static var objectOfAddToFavouiretViewModel = AddToFavouiretViewModel()
    var objectOfAddFavouiretNetworkManager = AddFavouiretNetworkManager()
    
    func addPlaceToFavouiretList(tokenTosend: String, placeIdIs: String, completion: @escaping((Bool) -> ())) {
        objectOfAddFavouiretNetworkManager.addFavouiretPlace(token: tokenTosend, placeid: placeIdIs){favStatus, favError in
            DispatchQueue.main.async {
                if favError == nil{
                    if favStatus == true{
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
