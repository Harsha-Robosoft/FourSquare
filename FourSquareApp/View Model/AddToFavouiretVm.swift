//
//  AddToFavouiretVm.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class AddToFavoriteViewModel {
    var apiResponce_shared = ApiResponce()
    static var addToFavoriteViewModel_shared = AddToFavoriteViewModel()
    
    func addPlaceToFavouiretList(tokenTosend: String, placeIdToSend: String, completion: @escaping((Bool) -> ())) {
        guard let url = URL(string:"https://four-square-three.vercel.app/api/addFavourite") else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenTosend)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameter = [
            "_id": placeIdToSend
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        apiResponce_shared.postApiResonce(request: request){ data, status, error in
            DispatchQueue.main.async {
                if error != nil && status != true{
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
}
