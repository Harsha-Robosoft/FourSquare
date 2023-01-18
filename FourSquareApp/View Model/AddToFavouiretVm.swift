//
//  AddToFavouiretVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class AddToFavoriteViewModel {
    static var objectOfAddToFavoriteViewModel = AddToFavoriteViewModel()
    var objectOfAddFavoriteNetworkManager = AddFavoriteNetworkManager()
    
    func addPlaceToFavouiretList(tokenTosend: String, placeIdIs: String, completion: @escaping((Bool) -> ())) {
        objectOfAddFavoriteNetworkManager.addFavouiretPlace(token: tokenTosend, placeid: placeIdIs){favStatus, favError in
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
